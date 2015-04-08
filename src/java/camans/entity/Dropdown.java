/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class Dropdown {
    
    //attributes
    private int id;
    private String dropdownType;
    private String name;
    private String remark;
    private int displayRank;
    /*
     * creates a new dropdown object with id
     * @param id identifier of dropdown
     * @param dropdownType type of dropdown
     * @param name of dropdown
     * @param remark of dropdown
     * @param display rank of dropdown
     */
    public Dropdown(int id, String dropdownType, String name, String remark, int displayRank) {
        this.id = id;
        this.dropdownType = dropdownType;
        this.name = name;
        this.remark = remark;
        this.displayRank = displayRank;
    }
    /*
     * creates a new dropdown object without id
     * @param dropdownType type of dropdown
     * @param name of dropdown
     * @param remark of dropdown
     * @param display rank of dropdown
     */
    public Dropdown(String dropdownType, String name, String remark, int displayRank) {
        this.dropdownType = dropdownType;
        this.name = name;
        this.remark = remark;
        this.displayRank = displayRank;
    }
    /**
     * getter method for id of dropdown
     * @return id of dropdown
     */
    public int getId() {
        return id;
    }
    /**
     * setter method for id of dropdown
     * @param id
     * sets current id of dropdown to the new id
     */
    public void setId(int id) {
        this.id = id;
    }
     /**
     * getter method for type of dropdown
     * @return type of dropdown
     */
    public String getDropdownType() {
        return dropdownType;
    }
    /**
     * setter method for type of dropdown
     * @param dropdownType
     * sets current type of dropdown to the new type
     */
    public void setDropdownType(String dropdownType) {
        this.dropdownType = dropdownType;
    }
     /**
     * getter method for name of dropdown
     * @return name of dropdown
     */
    public String getName() {
        return name;
    }
    /**
     * setter method for name of dropdown
     * @param name
     * sets current name of dropdown to the new name
     */
    public void setName(String name) {
        this.name = name;
    }
     /**
     * getter method for remark of dropdown
     * @return remark of dropdown
     */
    public String getRemark() {
        return remark;
    }
    /**
     * setter method for remark of dropdown
     * @param remark
     * sets current remark of dropdown to the new remark
     */
    public void setRemark(String remark) {
        this.remark = remark;
    }
     /**
     * getter method for display rank of dropdown
     * @return display rank of dropdown
     */
    public int getDisplayRank() {
        return displayRank;
    }
    /**
     * setter method for display rank of dropdown
     * @param displayRank
     * sets current display rank of dropdown to the new display rank
     */
    public void setDisplayRank(int displayRank) {
        this.displayRank = displayRank;
    }
    
    
}
