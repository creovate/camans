/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

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

    public static int[][] retrieveNationalityWorkpass(java.util.Date start, java.util.Date end) {
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
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return nationalityWorkpassArr;
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
