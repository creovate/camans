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

    public Worker(String finNumber, String name, Date registrationDate, String createdBy, 
            String createdFor, String gender, String nationality, String nationalityMore, Date dateOfBirth) {
        this.finNumber = finNumber;
        this.name = name;
        this.registrationDate = registrationDate;
        this.createdBy = createdBy;
        this.createdFor = createdFor;
        this.gender = gender;
        this.nationality = nationality;
        this.nationalityMore = nationalityMore;
        this.dateOfBirth = dateOfBirth;
    }

    public String getFinNumber() {
        return finNumber;
    }

    public void setFinNumber(String finNumber) {
        this.finNumber = finNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }


    public String getCreatedFor() {
        return createdFor;
    }

    public void setCreatedFor(String createdFor) {
        this.createdFor = createdFor;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getNationalityMore() {
        return nationalityMore;
    }

    public void setNationalityMore(String nationalityMore) {
        this.nationalityMore = nationalityMore;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    @Override
    public String toString() {
        return "Worker{" + "finNumber=" + finNumber + ", name=" + name + ", registrationDate=" + registrationDate + ", createdBy=" + createdBy + ", createdFor=" + createdFor + ", gender=" + gender + ", nationality=" + nationality + ", nationalityMore=" + nationalityMore + ", dateOfBirth=" + dateOfBirth + '}';
    }
  
}
