/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import java.sql.Date;

/**
 *
 * @author soemyatmyat
 */
public class Worker {
    
    //attributes
    private String finNumber;
    private String name;
    private Date registrationDate;
    private String createdBy;
    private String createdFor;
    private String gender;
    private String nationality;
    private String nationalityMore;
    private Date dateOfBirth;
    private String photoPath;

    /**
     *
     * @param finNumber FIN
     * @param name name
     * @param registrationDate registration date
     * @param createdBy created by
     * @param createdFor created for
     * @param gender gender
     * @param nationality  nationality
     * @param nationalityMore other nationality
     * @param dateOfBirth date of birth
     * @param photoPath path of photo
     */
    public Worker(String finNumber, String name, Date registrationDate, String createdBy, 
            String createdFor, String gender, String nationality, String nationalityMore, 
            Date dateOfBirth, String photoPath) {
        this.finNumber = finNumber;
        this.name = name;
        this.registrationDate = registrationDate;
        this.createdBy = createdBy;
        this.createdFor = createdFor;
        this.gender = gender;
        this.nationality = nationality;
        this.nationalityMore = nationalityMore;
        this.dateOfBirth = dateOfBirth;
        this.photoPath = photoPath;
    }

    /**
     * return path of photo
     * @return
     */
    public String getPhotoPath() {
        return photoPath;
    }

    /**
     * set path of photo
     * @param photoPath path of photo
     */
    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }

    /**
     * return  FIN
     * @return  FIN
     */
    public String getFinNumber() {
        return finNumber;
    }

    /**
     * set FIN
     * @param finNumber FIN
     */
    public void setFinNumber(String finNumber) {
        this.finNumber = finNumber;
    }

    /**
     * return  name
     * @return name
     */
    public String getName() {
        return name;
    }

    /**
     * set name
     * @param name name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * return registration date
     * @return registration date
     */
    public Date getRegistrationDate() {
        return registrationDate;
    }

    /**
     * set registration date
     * @param registrationDate registration date
     */
    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    /**
     * return created by
     * @return created by
     */
    public String getCreatedBy() {
        return createdBy;
    }

    /**
     * set created by
     * @param createdBy created by
     */
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    /**
     * return created for
     * @return created for
     */
    public String getCreatedFor() {
        return createdFor;
    }

    /**
     * set created for
     * @param createdFor created for
     */
    public void setCreatedFor(String createdFor) {
        this.createdFor = createdFor;
    }

    /**
     * return gender
     * @return gender
     */
    public String getGender() {
        return gender;
    }

    /**
     * set gender
     * @param gender gender
     */
    public void setGender(String gender) {
        this.gender = gender;
    }

    /**
     * return nationality
     * @return nationality
     */
    public String getNationality() {
        return nationality;
    }

    /**
     * set nationality
     * @param nationality nationality
     */
    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    /**
     * return other nationality
     * @return other nationality
     */
    public String getNationalityMore() {
        return nationalityMore;
    }

    /**
     * set other nationality
     * @param nationalityMore other nationality
     */
    public void setNationalityMore(String nationalityMore) {
        this.nationalityMore = nationalityMore;
    }

    /**
     * return  date of birth
     * @return date of birth
     */
    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    /**
     * set date of birth
     * @param dateOfBirth date of birth
     */
    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    @Override
    public String toString() {
        return "Worker{" + "finNumber=" + finNumber + ", name=" + name + ", registrationDate=" + registrationDate + ", createdBy=" + createdBy + ", createdFor=" + createdFor + ", gender=" + gender + ", nationality=" + nationality + ", nationalityMore=" + nationalityMore + ", dateOfBirth=" + dateOfBirth + '}';
    }
  
}
