/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import camans.entity.DataBean;
import camans.entity.NationalityWorkpassBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Nyein Su
 */
public class BeanFactory {

    private static java.sql.Date startDate;
    private static java.sql.Date endDate;

    public BeanFactory() {
    }

    public BeanFactory(java.util.Date startDate, java.util.Date endDate) {
        this.startDate = new java.sql.Date(startDate.getTime());
        this.endDate = new java.sql.Date(endDate.getTime());
    }

    public static java.util.Collection generateNationalityWorkpassBean() {
        java.util.Vector nationalityWorkerList = new java.util.Vector();

        int[][] nationalityWorkpassArr = null;
        ArrayList<ArrayList<String>> nationalityWorkpassList = new ArrayList<ArrayList<String>>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
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
            pstmt.setString(1, "Work_pass_type");
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

            // adding values into bean
            for (int i = 0; i < nationalityList.size(); i++) {
                String nationality = nationalityList.get(i);
                for (int j = 0; j < workPassList.size(); j++) {
                    String workPass = workPassList.get(j);
                    int qty = nationalityWorkpassArr[i][j];
                    NationalityWorkpassBean nwBean = new NationalityWorkpassBean(nationality, workPass, qty);
                    nationalityWorkerList.add(nwBean);

                }

            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return nationalityWorkerList;
    }

    public static java.util.Collection generateProblemWorkpassBean() {
        java.util.Vector problemWorkpassCol = new java.util.Vector();

        int[][] problemWorkpassArr = null;
        ArrayList<ArrayList<String>> problemWorkpassList = new ArrayList<ArrayList<String>>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();

            ArrayList<String> problemList = new ArrayList<String>();
            ArrayList<String> workPassList = new ArrayList<String>();

            //get the problem list
            sql = "select Name from tbl_dropdown where dropdownType = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Problem_type");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String problem = rs.getString(1);
                problemList.add(problem);
            }

            //get workpass list
            sql = "select Name from tbl_dropdown where dropdownType = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Work_pass_type");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String workpass = rs.getString(1);
                workPassList.add(workpass);
            }

            //create 2d array
            problemWorkpassArr = new int[problemList.size()][workPassList.size()];

            //get the queried list
            sql = "select Chief_problem, Workpass_type from tbl_problem P "
                    + "left join tbl_job J "
                    + "on P.Job_key = J.Job_key "
                    + "where Chief_problem_date between ? and ? "
                    + "group by Chief_problem, Workpass_type";
                    
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, startDate);
            pstmt.setDate(2, endDate);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String problem = rs.getString(1);
                String workpassType = rs.getString(2);
                ArrayList<String> problemWorkpass = new ArrayList<String>();
                problemWorkpass.add(problem);
                problemWorkpass.add(workpassType);

                problemWorkpassList.add(problemWorkpass);
            }

            //add into 2d Array
            for (int i = 0; i < problemWorkpassList.size(); i++) {
                ArrayList<String> problemWorkpass = problemWorkpassList.get(i);
                String queriedProblem = problemWorkpass.get(0);
                String queriedWorkpass = problemWorkpass.get(1);
                //loop nationality
                if (queriedProblem.length() > 0 && queriedWorkpass.length() > 0) {
                    problemLoop:
                    for (int j = 0; j < problemList.size(); j++) {

                        String problem = problemList.get(j);

                        //check whether the nationality is matched
                        //loop workpass only if the nationality matches
                        if (problem.equals(queriedProblem)) {

                            //loop workpass
                            for (int k = 0; k < workPassList.size(); k++) {
                                String workpass = workPassList.get(k);

                                //check whether the workpass matches
                                if (workpass.equals(queriedWorkpass)) {
                                    problemWorkpassArr[j][k]++;
                                    break problemLoop;
                                }

                            }
                        }
                    }
                }
            }

            // adding values into bean
            for (int i = 0; i < problemList.size(); i++) {
                String problem = problemList.get(i);
                for (int j = 0; j < workPassList.size(); j++) {
                    String workPass = workPassList.get(j);
                    int qty = problemWorkpassArr[i][j];
                    DataBean dataBean = new DataBean(problem, workPass, qty);
                    problemWorkpassCol.add(dataBean);

                }

            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
//        nationalityWorkerList.add(new NationalityWorkpassBean("Myanmar","Spass",2));
//        nationalityWorkerList.add(new NationalityWorkpassBean("Myanmar","Workpass",3));
//        nationalityWorkerList.add(new NationalityWorkpassBean("Myanmar","Socail Visit Pass",2));
//        nationalityWorkerList.add(new NationalityWorkpassBean("India","Spass",2));
//        nationalityWorkerList.add(new NationalityWorkpassBean("India","Workpass",3));
//        nationalityWorkerList.add(new NationalityWorkpassBean("India","Socail Visit Pass",2));
//        nationalityWorkerList.add(new NationalityWorkpassBean("Malaysia","Spass",4));
//        nationalityWorkerList.add(new NationalityWorkpassBean("Malaysia","Workpass",1));
//        nationalityWorkerList.add(new NationalityWorkpassBean("Malaysia","Socail Visit Pass",1));
        return problemWorkpassCol;
    }
    
    public static java.util.Collection generateProblemNationalityBean() {
        java.util.Vector problemNationalityCol = new java.util.Vector();

        int[][] problemNationalityArr = null;
        ArrayList<ArrayList<String>> problemNationalityList = new ArrayList<ArrayList<String>>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();

            ArrayList<String> problemList = new ArrayList<String>();
            ArrayList<String> nationalityList = new ArrayList<String>();

            //get the problem list
            sql = "select Name from tbl_dropdown where dropdownType = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Problem_type");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String problem = rs.getString(1);
                problemList.add(problem);
            }

            //get workpass list
            sql = "select Name from tbl_dropdown where dropdownType = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "Nationality_type");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String nationality = rs.getString(1);
                nationalityList.add(nationality);
            }

            //create 2d array
            problemNationalityArr = new int[problemList.size()][nationalityList.size()];

            //get the queried list
            sql = "select Chief_problem, Nationality "
                    + "from tbl_problem P "
                    + "left join tbl_worker w "
                    + "on Worker_FIN_number = FIN_number "
                    + "where Chief_problem_date between ? and ? "
                    + "group by Chief_problem,Nationality";
                    
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, startDate);
            pstmt.setDate(2, endDate);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String problem = rs.getString(1);
                String nationality = rs.getString(2);
                ArrayList<String> problemNationality = new ArrayList<String>();
                problemNationality.add(problem);
                problemNationality.add(nationality);

                problemNationalityList.add(problemNationality);
            }

            //add into 2d Array
            for (int i = 0; i < problemNationalityList.size(); i++) {
                ArrayList<String> problemNationality = problemNationalityList.get(i);
                String queriedProblem = problemNationality.get(0);
                String queriedNationality = problemNationality.get(1);
                //loop nationality
                if (queriedProblem.length() > 0 && queriedNationality.length() > 0) {
                    problemLoop:
                    for (int j = 0; j < problemList.size(); j++) {

                        String problem = problemList.get(j);

                        //check whether the nationality is matched
                        //loop workpass only if the nationality matches
                        if (problem.equals(queriedProblem)) {

                            //loop workpass
                            for (int k = 0; k < nationalityList.size(); k++) {
                                String nationality = nationalityList.get(k);

                                //check whether the workpass matches
                                if (nationality.equals(queriedNationality)) {
                                    problemNationalityArr[j][k]++;
                                    break problemLoop;
                                }

                            }
                        }
                    }
                }
            }

            // adding values into bean
            for (int i = 0; i < problemList.size(); i++) {
                String problem = problemList.get(i);
                for (int j = 0; j < nationalityList.size(); j++) {
                    String nationality = nationalityList.get(j);
                    int qty = problemNationalityArr[i][j];
                    DataBean dataBean = new DataBean(problem, nationality, qty);
                    problemNationalityCol.add(dataBean);

                }

            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return problemNationalityCol;
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
