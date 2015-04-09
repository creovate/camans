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

    /**
     *
     * @param nationality
     * @param workpass
     * @param numOfCases
     */
    public NationalityWorkpassBean(String nationality, String workpass, int numOfCases) {
        this.nationality = nationality;
        this.workpass = workpass;
        this.numOfCases = numOfCases;
    }

    /**
     * returns nationality
     * @return nationality
     */
    public String getNationality() {
        return nationality;
    }

    /**
     * set nationality
     * @param nationality
     */
    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    /**
     * returns workpass
     * @return workpass
     */
    public String getWorkpass() {
        return workpass;
    }

    /**
     * set workpass
     * @param workpass
     */
    public void setWorkpass(String workpass) {
        this.workpass = workpass;
    }

    /**
     * returns number of cases by nationality and workpass
     * @return number of cases by nationality and workpass
     */
    public int getNumOfCases() {
        return numOfCases;
    }

    /**
     * set number of cases by nationality and workpass
     * @param numOfCases
     */
    public void setNumOfCases(int numOfCases) {
        this.numOfCases = numOfCases;
    }
    
}
