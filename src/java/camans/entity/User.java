/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class User {
    
    //attributes
    private String nricNumber;
    private String fullName;
    private String alias;
    private String username;
    private String password;
    private String emailAddress;
    private String phoneNumber;
    private String gender;
    private String role;
    private String photoPath;
    private String status;

    public User(String nricNumber, String fullName, String alias, String username, String password,  
            String emailAddress, String phoneNumber, String gender, String role, String photoPath,
            String status) {
        this.nricNumber = nricNumber;
        this.fullName = fullName;
        this.alias = alias;
        this.username = username;
        this.password = password;
        this.emailAddress = emailAddress;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.role = role;
        this.photoPath = photoPath;
        this.status = status;
    }

    public User(String nricNumber, String fullName, String alias, String username, String emailAddress, 
            String phoneNumber, String gender, String role, String photoPath, String status) {
        this.nricNumber = nricNumber;
        this.fullName = fullName;
        this.alias = alias;
        this.username = username;
        this.emailAddress = emailAddress;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.role = role;
        this.photoPath = photoPath;
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    
    public String getNricNumber() {
        return nricNumber;
    }

    public void setNricNumber(String nricNumber) {
        this.nricNumber = nricNumber;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }
    
    public boolean authenticate(String password) {
        
        try {
            return PasswordHash.validatePassword(password, this.password);
        } catch (Exception ex) {
            //do not process & show error page
            return false;
        }  
        
//return password.equals(this.password);
    }

    @Override
    public String toString() {
        return "User{" + "nricNumber=" + nricNumber + ", fullName=" + fullName + ", alias=" + alias + ", username=" + username + ", password=" + password + ", emailAddress=" + emailAddress + ", phoneNumber=" + phoneNumber + ", gender=" + gender + ", role=" + role + ", photoPath=" + photoPath + '}';
    }
    
}
