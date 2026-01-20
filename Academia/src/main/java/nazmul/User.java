package nazmul;

 /**
  * Model/entity representing an application user.
  *
  * <p>This is a simple JavaBean used across the application:
  * <ul>
  *   <li>Stored in the HTTP session as attribute {@code "user"} after login</li>
  *   <li>Populated by {@link UserDAO} and {@link CourseDAO}</li>
  *   <li>Used by JSP pages to enforce role-based access</li>
  * </ul>
  *
  * <p>Fields map to the {@code users} table.
  */
public class User {
    /** Primary key from {@code users.id}. */
    private int id;

    /** Username from {@code users.username}. */
    private String username;

    /** Password from {@code users.password} (currently stored as plain text). */
    private String password;

    /** Role from {@code users.role} (admin|teacher|student). */
    private String role;

    /** Full display name from {@code users.full_name}. */
    private String fullName;

    /** Email from {@code users.email}. */
    private String email;
    
    /** No-arg constructor for JavaBean usage. */
    public User() {}
    
    /**
     * Convenience constructor for fully-populated users.
     */
    public User(int id, String username, String password, String role, String fullName, String email) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.role = role;
        this.fullName = fullName;
        this.email = email;
    }
    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}

