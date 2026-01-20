package nazmul;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import nazmul.Course;
import nazmul.DatabaseUtil;
import nazmul.User;

 /**
  * Data Access Object (DAO) for course-related operations.
  *
  * <p>This DAO is used by:
  * <ul>
  *   <li><strong>Admin</strong>: create/edit/delete courses, view teachers/students, view all courses</li>
  *   <li><strong>Student</strong>: view enrolled courses, view available courses, enroll into a course</li>
  *   <li><strong>Teacher</strong>: view assigned courses, view students in a course</li>
  * </ul>
  *
  * <p>Tables referenced by this class:
  * <ul>
  *   <li>{@code courses}</li>
  *   <li>{@code users}</li>
  *   <li>{@code student_courses}</li>
  * </ul>
  *
  * <p><strong>Note:</strong> This class also contains a couple of user profile
  * helper methods ({@link #getUserById(int)} and {@link #updateUser(User)}),
  * which are used by the profile update workflow.
  */
public class CourseDAO {

     /**
      * Admin feature: add a new course and assign it to a teacher.
      *
      * @param course the course entity containing code/name/teacherId
      * @return {@code true} if inserted successfully, otherwise {@code false}
      */
    public boolean addCourse(Course course) {
        String query = "INSERT INTO courses (course_code, course_name, teacher_id) VALUES (?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, course.getCourseCode());
            stmt.setString(2, course.getCourseName());
            stmt.setInt(3, course.getTeacherId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
     /**
      * Admin feature: list all courses.
      *
      * <p>Includes teacher name by joining {@code courses.teacher_id} to
      * {@code users.id}.
      *
      * @return list of all courses (may be empty)
      */
    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.*, u.full_name as teacher_name FROM courses c " +
                       "LEFT JOIN users u ON c.teacher_id = u.id";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setCourseName(rs.getString("course_name"));
                course.setTeacherId(rs.getInt("teacher_id"));
                course.setTeacherName(rs.getString("teacher_name"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return courses;
    }
    
     /**
      * Admin feature: list all teachers.
      *
      * @return all users where {@code role = 'teacher'}
      */
    public List<User> getAllTeachers() {
        List<User> teachers = new ArrayList<>();
        String query = "SELECT * FROM users WHERE role = 'teacher'";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                User teacher = new User();
                teacher.setId(rs.getInt("id"));
                teacher.setUsername(rs.getString("username"));
                teacher.setFullName(rs.getString("full_name"));
                teacher.setEmail(rs.getString("email"));
                teachers.add(teacher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return teachers;
    }
    
     /**
      * Admin feature: list all students.
      *
      * @return all users where {@code role = 'student'}
      */
    public List<User> getAllStudents() {
        List<User> students = new ArrayList<>();
        String query = "SELECT * FROM users WHERE role = 'student' ORDER BY full_name";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                User student = new User();
                student.setId(rs.getInt("id"));
                student.setUsername(rs.getString("username"));
                student.setFullName(rs.getString("full_name"));
                student.setEmail(rs.getString("email"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return students;
    }
    
     /**
      * Student feature: list courses that the given student is enrolled in.
      *
      * <p>Uses {@code student_courses} join table.
      *
      * @param studentId id from {@code users.id}
      * @return enrolled courses (may be empty)
      */
    public List<Course> getCoursesByStudentId(int studentId) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.*, u.full_name as teacher_name FROM courses c " +
                       "LEFT JOIN users u ON c.teacher_id = u.id " +
                       "INNER JOIN student_courses sc ON c.id = sc.course_id " +
                       "WHERE sc.student_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setCourseName(rs.getString("course_name"));
                course.setTeacherId(rs.getInt("teacher_id"));
                course.setTeacherName(rs.getString("teacher_name"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return courses;
    }
    
     /**
      * Student feature: list courses that the student is NOT enrolled in.
      *
      * @param studentId id from {@code users.id}
      * @return available courses to enroll (may be empty)
      */
    public List<Course> getAvailableCourses(int studentId) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.*, u.full_name as teacher_name FROM courses c " +
                       "LEFT JOIN users u ON c.teacher_id = u.id " +
                       "WHERE c.id NOT IN (SELECT course_id FROM student_courses WHERE student_id = ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setCourseName(rs.getString("course_name"));
                course.setTeacherId(rs.getInt("teacher_id"));
                course.setTeacherName(rs.getString("teacher_name"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return courses;
    }
    
     /**
      * Student feature: enroll a student into a course.
      *
      * @param studentId id from {@code users.id}
      * @param courseId id from {@code courses.id}
      * @return {@code true} if an enrollment row was inserted
      */
    public boolean enrollCourse(int studentId, int courseId) {
        String query = "INSERT INTO student_courses (student_id, course_id) VALUES (?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
     /**
      * Teacher feature: list courses assigned to the teacher.
      *
      * @param teacherId teacher user id
      * @return courses taught by this teacher
      */
    public List<Course> getCoursesByTeacherId(int teacherId) {
        List<Course> courses = new ArrayList<>();
        String query = "SELECT c.*, u.full_name as teacher_name FROM courses c " +
                       "LEFT JOIN users u ON c.teacher_id = u.id " +
                       "WHERE c.teacher_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, teacherId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setCourseCode(rs.getString("course_code"));
                course.setCourseName(rs.getString("course_name"));
                course.setTeacherId(rs.getInt("teacher_id"));
                course.setTeacherName(rs.getString("teacher_name"));
                courses.add(course);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return courses;
    }
    
     /**
      * Teacher feature: list students enrolled in a course.
      *
      * @param courseId course id
      * @return list of student users enrolled in the course
      */
    public List<User> getStudentsByCourseId(int courseId) {
        List<User> students = new ArrayList<>();
        String query = "SELECT u.* FROM users u " +
                       "INNER JOIN student_courses sc ON u.id = sc.student_id " +
                       "WHERE sc.course_id = ? AND u.role = 'student'";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, courseId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                User student = new User();
                student.setId(rs.getInt("id"));
                student.setUsername(rs.getString("username"));
                student.setFullName(rs.getString("full_name"));
                students.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return students;
    }

     /**
      * Admin feature: update course fields (code/name/assigned teacher).
      *
      * @param course course with updated fields (must include {@code id})
      * @return {@code true} if a row was updated
      */
    public boolean updateCourse(Course course) {
        String query = "UPDATE courses SET course_code = ?, course_name = ?, teacher_id = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, course.getCourseCode());
            stmt.setString(2, course.getCourseName());
            stmt.setInt(3, course.getTeacherId());
            stmt.setInt(4, course.getId());
 
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
 
     /**
      * Admin feature: delete a course by id.
      *
      * @param courseId course id
      * @return {@code true} if a row was deleted
      */
    public boolean deleteCourse(int courseId) {
        String query = "DELETE FROM courses WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, courseId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
 
     /**
      * Profile feature helper: fetch a {@link User} by primary key.
      *
      * <p>Used by teacher/student dashboards and profile update servlet.
      *
      * @param id user id
      * @return user or {@code null} if not found
      */
    public User getUserById(int id) {
        User user = null;
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE id = ?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPassword(rs.getString("password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
 
     /**
      * Profile feature helper: update user profile fields.
      *
      * @param user updated user
      */
    public void updateUser(User user) {
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "UPDATE users SET full_name=?, username=?, email=?, password=? WHERE id=?")) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
