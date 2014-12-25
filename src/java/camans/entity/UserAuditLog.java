/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class UserAuditLog {
    
    //attributes
    private int id;
    private String username;
    private String key;
    private String workerFin;
    private String actionType;
    private String actionDesc;

    public UserAuditLog(String username, String key, String workerFin, String actionType, String actionDesc) {
        this.username = username;
        this.key = key;
        this.workerFin = workerFin;
        this.actionType = actionType;
        this.actionDesc = actionDesc;
    }

    public UserAuditLog(int id, String username, String key, String workerFin, 
            String actionType, String actionDesc) {
        this.id = id;
        this.username = username;
        this.key = key;
        this.workerFin = workerFin;
        this.actionType = actionType;
        this.actionDesc = actionDesc;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getWorkerFin() {
        return workerFin;
    }

    public void setWorkerFin(String workerFin) {
        this.workerFin = workerFin;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public String getActionDesc() {
        return actionDesc;
    }

    public void setActionDesc(String actionDesc) {
        this.actionDesc = actionDesc;
    }

    
}
