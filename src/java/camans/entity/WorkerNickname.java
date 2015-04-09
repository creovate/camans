/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class WorkerNickname {
    
    //attributes
    private String workerFinNum;
    private int id;
    private String nickname;

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param nickname nickname
     */
    public WorkerNickname(String workerFinNum, int id, String nickname) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.nickname = nickname;
    }
    
    /**
     *
     * @param workerFinNum FIN
     * @param nickname nickname
     */
    public WorkerNickname(String workerFinNum, String nickname) {
        this.workerFinNum = workerFinNum;
        this.nickname = nickname;
    }

    /**
     *return FIN
     * @return FIN
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }

    /**
     *set FIN
     * @param workerFinNum FIN
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }

    /**
     *return nickname
     * @return nickname
     */
    public String getNickname() {
        return nickname;
    }

    /**
     *set nickname
     * @param nickname nickname
     */
    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    /**
     *return id
     * @return id
     */
    public int getId() {
        return id;
    }

    /**
     *set id
     * @param id id
     */
    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "WorkerNickname{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", nickname=" + nickname + '}';
    }
    
   
    public String toString2() {
        return "Nickname [nickname=" + nickname + ']';
    }    
    
    
    
}
