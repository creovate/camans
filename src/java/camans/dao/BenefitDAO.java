/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import camans.entity.Benefit;
import camans.entity.Problem;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author soemyatmyat
 */
public class BenefitDAO {


    /*Benefit*/
    public static ArrayList<Integer> retrieveBenefitsIdsOfProblem(Problem problem, String benefitType) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_benefit where Worker_FIN_number = ? AND Job_key =? "
                    + "AND Prob_key=? AND Bene_type=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            pstmt.setString(4, benefitType);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    public static ArrayList<Integer> retrieveBenefitsIdsOfCategory(Problem problem, String benefitCategory, java.util.Date startDateIn, java.util.Date endDateIn) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "select Remark, Name, t1.* from tbl_dropdown inner join "
                    + "(select * from tbl_benefit where Bene_date between ? and ?) as t1 "
                    + "on Name = t1.Bene_type "
                    + "where dropdownType = \"Bene_type\" "
                    + "and remark = ?"
                    + "order by displayRank";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, problem.getWorkerFinNum());
            pstmt.setInt(2, problem.getJobKey());
            pstmt.setInt(3, problem.getProbKey());
            pstmt.setString(4, benefitCategory);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt(1);
                ids.add(id);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql);
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }

        return ids;
    }

    public static Benefit retrieveBenefitById(int id) {
        Benefit benefit = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Bene_date, Bene_giver, Bene_type,Bene_type_more,"
                    + " Bene_serial, Bene_purpose,Bene_rem, Bene_value,"
                    + "Worker_FIN_number, Job_key, Prob_key"
                    + " FROM tbl_benefit where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Date beneDate = rs.getDate(1);
                String beneGiver = rs.getString(2);
                String beneType = rs.getString(3);
                String beneTypeMore = rs.getString(4);
                String beneSerial = rs.getString(5);
                String benePurpose = rs.getString(6);
                String beneRemark = rs.getString(7);
                double beneValue = rs.getDouble(8);
                String workerFinNumber = rs.getString(9);
                int jobKey = rs.getInt(10);
                int probKey = rs.getInt(11);
                benefit = new Benefit(id, workerFinNumber, jobKey, probKey,
                        beneDate, beneGiver, beneType, beneTypeMore, beneSerial, benePurpose,
                        beneRemark, beneValue);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Benefit={" + benefit + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return benefit;
    }

    public static void addBenefit(Benefit benefit) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_benefit (Bene_date, Bene_giver, Bene_type,Bene_type_more,"
                    + "Bene_serial, Bene_purpose,Bene_rem,Bene_value, "
                    + "Worker_FIN_number, Job_key, Prob_key) "
                    + "VALUES (?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, benefit.getIssueDate());
            pstmt.setString(2, benefit.getBenefitGiver());
            pstmt.setString(3, benefit.getBenefitType());
            pstmt.setString(4, benefit.getBenefitTypeMore());
            pstmt.setString(5, benefit.getBenefitSerial());
            pstmt.setString(6, benefit.getBenefitPurpose());
            pstmt.setString(7, benefit.getBenefitRemark());
            pstmt.setDouble(8, benefit.getBenefitValue());
            pstmt.setString(9, benefit.getWorkerFinNumber());
            pstmt.setInt(10, benefit.getJobKey());
            pstmt.setInt(11, benefit.getProblemKey());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "benefit: " + benefit + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    public static void updateBenefit(Benefit benefit) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "UPDATE tbl_benefit SET Bene_date = ? , Bene_giver = ?, Bene_type=?, Bene_type_more=?,"
                    + "Bene_serial=?,Bene_purpose=?, Bene_rem =?, Bene_value=? "
                    + "WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDate(1, benefit.getIssueDate());
            pstmt.setString(2, benefit.getBenefitGiver());
            pstmt.setString(3, benefit.getBenefitType());
            pstmt.setString(4, benefit.getBenefitTypeMore());
            pstmt.setString(5, benefit.getBenefitSerial());
            pstmt.setString(6, benefit.getBenefitPurpose());
            pstmt.setString(7, benefit.getBenefitRemark());
            pstmt.setDouble(8, benefit.getBenefitValue());
            pstmt.setInt(9, benefit.getId());

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Benefit={" + benefit + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    public static void deleteBenefit(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "DELETE FROM tbl_benefit WHERE ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "Benefit ID={" + id + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
        }
    }

    public static void deleteAll() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();

            sql = "DELETE FROM tbl_benefit";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from Benefit Table. ");
        } finally {
            ConnectionManager.close(conn, pstmt, null);
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
