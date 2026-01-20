package nazmul;

 /**
  * Model/entity representing a course.
  *
  * <p>This is a simple JavaBean used by {@link CourseDAO} and JSP pages.
  * Fields map to the {@code courses} table, with {@code teacherName} typically
  * populated from a join with the {@code users} table.
  */
public class Course {
    /** Primary key from {@code courses.id}. */
    private int id;

    /** Course code (e.g., CSE101) from {@code courses.course_code}. */
    private String courseCode;

    /** Course display name from {@code courses.course_name}. */
    private String courseName;

    /** Assigned teacher id from {@code courses.teacher_id}. */
    private int teacherId;

    /** Teacher full name (derived via join from {@code users.full_name}). */
    private String teacherName;
    
    /** No-arg constructor (required for JavaBean usage in JSP/DAO population). */
    public Course() {}
    
    /**
     * Convenience constructor for populating all fields.
     */
    public Course(int id, String courseCode, String courseName, int teacherId, String teacherName) {
        this.id = id;
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.teacherId = teacherId;
        this.teacherName = teacherName;
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getCourseCode() { return courseCode; }
    public void setCourseCode(String courseCode) { this.courseCode = courseCode; }
    
    public String getCourseName() { return courseName; }
    public void setCourseName(String courseName) { this.courseName = courseName; }
    
    public int getTeacherId() { return teacherId; }
    public void setTeacherId(int teacherId) { this.teacherId = teacherId; }
    
    public String getTeacherName() { return teacherName; }
    public void setTeacherName(String teacherName) { this.teacherName = teacherName; }
}