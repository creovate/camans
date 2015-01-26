/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.dao;

import camans.entity.User;
import camans.entity.UserAuditLog;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author soemyatmyat
 */
public class UserAuditLogDAO {
 
    public static ArrayList<Integer> retrieveUserAuditLogIdsOfUser(User user) {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_audit where username = ?;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUsername());
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

    public static ArrayList<Integer> retrievelast7daysUserAuditLogIds() {
        ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_audit where Entry_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) order by ID DESC";
            pstmt = conn.prepareStatement(sql);
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

    public static ArrayList<Integer> retrieveUserAduitLogIdsBySearch(java.util.Date startDate, 
            java.util.Date endDate) {
    ArrayList<Integer> ids = new ArrayList<Integer>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT ID FROM tbl_audit where Entry_date >='" + startDate + "' AND Entry_date < '"
                    + endDate + "' + INTERVAL 1 DAY;";
            pstmt = conn.prepareStatement(sql);
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
    
    public static UserAuditLog retrieveUserAduitLogById(int id) {
        UserAuditLog userAuditLog = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";

        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT username, Key_log, FIN_log, Action_type, Action_description_log "
                    + " FROM tbl_audit where ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                String username = rs.getString(1);
                String keyLogged = rs.getString(2);
                String finLogged = rs.getString(3);
                String actionType = rs.getString(4);
                String actionDesc = rs.getString(5);
                userAuditLog = new UserAuditLog(id, username, keyLogged, finLogged, actionType, actionDesc);
            }

        } catch (SQLException ex) {
            handleSQLException(ex, sql, "UserAuditLog={" + userAuditLog + "}");
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
        return userAuditLog;
    }

    public static void addUserAuditLog(UserAuditLog userAuditLog) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
            conn = ConnectionManager.getConnection();
            sql = "INSERT INTO tbl_audit (username, Key_log, "
                    + "FIN_log, Action_type, "
                    + "Action_description_log) "
                    + "VALUES (?,?,?,?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userAuditLog.getUsername());
            pstmt.setString (2, userAuditLog.getKey());
            pstmt.setString (3, userAuditLog.getWorkerFin());
            pstmt.setString(4, userAuditLog.getActionType());
            pstmt.setString(5, userAuditLog.getActionDesc());
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "UserAuditLog: " + userAuditLog + "}");
        } finally {
            ConnectionManager.close(conn, pstmt);
        }
    }

    public static Timestamp retrieveTimeStamp(UserAuditLog userAuditLog) {
        Timestamp timeStamp = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            sql = "SELECT Entry_date FROM tbl_audit where ID = ?;";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userAuditLog.getId());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                timeStamp = rs.getTimestamp(1);
            }
            return timeStamp;
            
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "UserAuditLog={" + userAuditLog + "}");           
        } finally {
            ConnectionManager.close(conn, pstmt, rs);
        }
    
        
        return timeStamp;
    }
    
    public static void deleteAll(){
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        
        try {
            conn = ConnectionManager.getConnection();
            
            sql = "DELETE FROM tbl_audit";
            pstmt = conn.prepareStatement(sql);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            handleSQLException(ex, sql, "not able to delete data from tbl_audit Table. ");
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
