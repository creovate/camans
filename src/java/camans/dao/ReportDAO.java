/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import au.com.bytecode.opencsv.CSVWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nyein Su
 */
public class ReportDAO {

    public static String[][] retrieveNationalityWorkpass(java.util.Date start, java.util.Date end) {
        String[][] returnDataArr = null;
        int[][] nationalityWorkpassArr = null;
        ArrayList<ArrayList<String>> nationalityWorkpassList = new ArrayList<ArrayList<String>>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            java.sql.Date startDate = new java.sql.Date(start.getTime());
            java.sql.Date endDate = new java.sql.Date(end.getTime());
            conn = ConnectionManager.getConnection();

            ArrayList<String> nationalityList = new ArrayList<String>();
            ArrayList<String> workPassList = new ArrayList<String>();

            //get the nationality list
            sql = "select Name from tbl_dropdown where dropdownType = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Nationality_type");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String nationality = rs.getString(1);
                nationalityList.add(nationality);
            }

            //get workpass list
            sql = "select Name from tbl_dropdown where dropdownType = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "pass_type");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String workpass = rs.getString(1);
                workPassList.add(workpass);
            }

            //create 2d array
            nationalityWorkpassArr = new int[nationalityList.size()][workPassList.size()];
            returnDataArr = new String[nationalityList.size() + 1][workPassList.size() + 1];

            //get the queried list
            sql = "select nationality, Workpass_type from tbl_worker "
                    + "left join tbl_job as t1 "
                    + "on Fin_number = t1.Worker_FIN_number "
                    + "left join tbl_problem as t2 "
                    + "on Fin_number = t2.Worker_FIN_number "
                    + "where Chief_problem_date between ? and ? "
                    + "group by Fin_number, Workpass_type";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, startDate);
            pstmt.setDate(2, endDate);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String nationality = rs.getString(1);
                String workpassType = rs.getString(2);
                ArrayList<String> nationalityWorkpass = new ArrayList<String>();
                nationalityWorkpass.add(nationality);
                nationalityWorkpass.add(workpassType);

                nationalityWorkpassList.add(nationalityWorkpass);
            }

            //add into 2d Array
            for (int i = 0; i < nationalityWorkpassList.size(); i++) {
                ArrayList<String> nationalityWorkpass = nationalityWorkpassList.get(i);
                String queriedNationality = nationalityWorkpass.get(0);
                String queriedWorkpass = nationalityWorkpass.get(1);
                //loop nationality
                if (queriedNationality.length() > 0 && queriedWorkpass.length() > 0) {
                    nationalityLoop:
                    for (int j = 0; j < nationalityList.size(); j++) {

                        String nationality = nationalityList.get(j);

                        //check whether the nationality is matched
                        //loop workpass only if the nationality matches
                        if (nationality.equals(queriedNationality)) {

                            //loop workpass
                            for (int k = 0; k < workPassList.size(); k++) {
                                String workpass = workPassList.get(k);

                                //check whether the workpass matches
                                if (workpass.equals(queriedWorkpass)) {
                                    nationalityWorkpassArr[j][k]++;
                                    break nationalityLoop;
                                }

                            }
                        }
                    }
                }
            }
            //System.out.println(nationalityWorkpassArr);
            //adding headers
            for (int i = 1; i <= workPassList.size(); i++) {
                returnDataArr[0][i] = workPassList.get(i - 1);
            }
            returnDataArr[0][0] = "";
            if (nationalityWorkpassArr != null) {
                for (int i = 1; i <= nationalityList.size(); i++) {
                    String nationality = nationalityList.get(i - 1);
                    returnDataArr[i][0] = nationality;
                    for (int j = 1; j <= workPassList.size(); j++) {
                        int data = nationalityWorkpassArr[i-1][j-1];

                        returnDataArr[i][j] = data + "";


                    }

                }
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return returnDataArr;
    }

    public static void generateCSVFile(String outputFile, java.util.Date startDate, java.util.Date endDate) {
        // before we open the file check to see if it already exists
        boolean alreadyExists = new File(outputFile).exists();

        try {
            // use FileWriter constructor that specifies open for appending
            CSVWriter writer = new CSVWriter(new FileWriter(outputFile,false));

            // get data
            String[][] data = retrieveNationalityWorkpass(startDate, endDate);
            for (int i = 0; i < data.length; i++) {
                String[] dataRow = data[i];
                writer.writeNext(dataRow);
            }
            writer.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void handleSQLException(SQLException ex, String sql, String... parameters) {
        String msg = "Unable to access data; SQL=" + sql + "\n";
        for (String parameter : parameters) {
            msg += "," + parameter + ex.getMessage();
        }
        Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, msg, ex);
        throw new RuntimeException(msg, ex);
    }
}
