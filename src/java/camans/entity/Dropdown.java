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

    public Dropdown(int id, String dropdownType, String name, String remark, int displayRank) {
        this.id = id;
        this.dropdownType = dropdownType;
        this.name = name;
        this.remark = remark;
        this.displayRank = displayRank;
    }

    public Dropdown(String dropdownType, String name, String remark, int displayRank) {
        this.dropdownType = dropdownType;
        this.name = name;
        this.remark = remark;
        this.displayRank = displayRank;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDropdownType() {
        return dropdownType;
    }

    public void setDropdownType(String dropdownType) {
        this.dropdownType = dropdownType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getDisplayRank() {
        return displayRank;
    }

    public void setDisplayRank(int displayRank) {
        this.displayRank = displayRank;
    }
    
    
}
