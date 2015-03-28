/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRField;

/**
 *
 * @author Nyein Su
 */
public class JasperDataSourceBuilder implements JRDataSource {

    private int rowIndex = 0;
    private int columnIndex = 0;

    private int[][] data = null;

    public JasperDataSourceBuilder(int[][] dataObject){
        data = dataObject;
    }

    @Override
    public boolean next() throws JRException {
        boolean hasMore = false;
        if((data != null && data.length > 0)){
            if(rowIndex < data.length){
                if(columnIndex < data[rowIndex].length){
                    hasMore = true;
                }else{
                    rowIndex ++;
                    columnIndex = 0;
                    hasMore = true;
                }
            }
          }
        if(rowIndex >= data.length){
            hasMore = false;
        }
        return hasMore;
    }

    @Override
    public Object getFieldValue(JRField arg0) throws JRException {
        String fieldVal = String.valueOf(data[rowIndex][columnIndex]);
        columnIndex++;
        return fieldVal;
    }

    public int[][] getData() {
        return data;
    }

    public void setData(int[][] data) {
        this.data = data;
    }

}