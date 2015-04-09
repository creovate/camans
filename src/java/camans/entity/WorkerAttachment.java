/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

/**
 *
 * @author soemyatmyat
 */
public class WorkerAttachment {
    
    //attributes
    private String workerFinNum;
    private int id;
    private String documentName;
    private String filePath;
    private String submitBy;

    /**
     *
     * @param workerFinNum FIN
     * @param id id
     * @param documentName document name
     * @param filePath file path
     * @param submitBy submit by
     */
    public WorkerAttachment(String workerFinNum, int id, String documentName, String filePath, String submitBy) {
        this.workerFinNum = workerFinNum;
        this.id = id;
        this.documentName = documentName;
        this.filePath = filePath;
        this.submitBy = submitBy;
    }

    /**
     *
     * @param workerFinNum FIN
     * @param documentName document name
     * @param filePath file path
     * @param submitBy submit by
     */
    public WorkerAttachment(String workerFinNum, String documentName, String filePath, String submitBy) {
        this.workerFinNum = workerFinNum;
        this.documentName = documentName;
        this.filePath = filePath;
        this.submitBy = submitBy;
    }

    /**
     * return FIN
     * @return FIN
     */
    public String getWorkerFinNum() {
        return workerFinNum;
    }

    /**
     * set FIN
     * @param workerFinNum FIN
     */
    public void setWorkerFinNum(String workerFinNum) {
        this.workerFinNum = workerFinNum;
    }

    /**
     * return id
     * @return id
     */
    public int getId() {
        return id;
    }

    /**
     * set id
     * @param id id
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * return document name
     * @return document name
     */
    public String getDocumentName() {
        return documentName;
    }

    /**
     * set document name
     * @param documentName document name
     */
    public void setDocumentName(String documentName) {
        this.documentName = documentName;
    }

    /**
     * return file path
     * @return file path
     */
    public String getFilePath() {
        return filePath;
    }

    /**
     * set file path
     * @param filePath file path
     */
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    /**
     * return submit by
     * @return submit by
     */
    public String getSubmitBy() {
        return submitBy;
    }

    /**
     * set submit by
     * @param submitBy submit by
     */
    public void setSubmitBy(String submitBy) {
        this.submitBy = submitBy;
    }

    @Override
    public String toString() {
        return "WorkerAttachment{" + "workerFinNum=" + workerFinNum + ", id=" + id + 
                ", documentName=" + documentName + ", filePath=" + filePath + 
                ", submitBy=" + submitBy + '}';
    }
    
    
    public String toString2() {
        return "Attachment [documentName=" + documentName + ']';
    }
    
}
