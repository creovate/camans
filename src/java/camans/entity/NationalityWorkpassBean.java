/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author Nyein Su
 */
public class NationalityWorkpassBean {
    private String nationality;
    private String workpass;
    private int numOfCases;

    public NationalityWorkpassBean(String nationality, String workpass, int numOfCases) {
        this.nationality = nationality;
        this.workpass = workpass;
        this.numOfCases = numOfCases;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getWorkpass() {
        return workpass;
    }

    public void setWorkpass(String workpass) {
        this.workpass = workpass;
    }

    public int getNumOfCases() {
        return numOfCases;
    }

    public void setNumOfCases(int numOfCases) {
        this.numOfCases = numOfCases;
    }
    
}
