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

    public WorkerNickname(String workerFinNum, int id, String nickname) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.nickname = nickname;
    }
    
    public WorkerNickname(String workerFinNum, String nickname) {
        this.workerFinNum = workerFinNum;
        this.nickname = nickname;
    }

    public String getWorkerFinNum() {
        return workerFinNum;
    }

    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }



    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "WorkerNickname{" + "workerFinNum=" + workerFinNum + ", id=" + id + ", nickname=" + nickname + '}';
    }
    
    
    
}
