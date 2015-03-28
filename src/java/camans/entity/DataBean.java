/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author Nyein Su
 */
public class DataBean {
    
    String rowLabel;
    String colLabel;
    int count;

    /**
     *
     * @param rowLabel
     * @param colLabel
     * @param count
     */
    public DataBean(String rowLabel, String colLabel, int count) {
        this.rowLabel = rowLabel;
        this.colLabel = colLabel;
        this.count = count;
    }

    /**
     * returns row label of pivot table
     * @return row label of pivot table
     */
    public String getRowLabel() {
        return rowLabel;
    }

    /**
     * set row label of pivot table
     * @param rowLabel row label of pivot table
     */
    public void setRowLabel(String rowLabel) {
        this.rowLabel = rowLabel;
    }

    /**
     * returns column label of pivot table
     * @return column label of pivot table
     */
    public String getColLabel() {
        return colLabel;
    }

    /**
     * returns column label of pivot table
     * @param colLabel column label of pivot table
     */
    public void setColLabel(String colLabel) {
        this.colLabel = colLabel;
    }

    /**
     * returns summation value of row and column
     * @return summation value of row and column
     */
    public int getCount() {
        return count;
    }

    /**
     * set summation value of row and column
     * @param count summation value of row and column
     */
    public void setCount(int count) {
        this.count = count;
    }
}
