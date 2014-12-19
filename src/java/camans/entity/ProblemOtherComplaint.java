/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package camans.entity;

import java.sql.Date;

/**
 *
 * @author Xiaomeng
 */
public class ProblemOtherComplaint {
	private int id;
	private String workerFinNumber;
	private int jobKey;
	private int problemKey;
	private Date otherComplaintDate;
	private String otherComplaintAgency;
	private String otherComplaintWho;
	private String otherComplaintWhoMore;
	private String otherComplaintMode;
	private String otherComplaintModeMore;
	private String otherComplaintDetails;
	private String otherComplaintRemark;
	
	//constructor with id
	public ProblemOtherComplaint(int id, String workerFinNumber, int jobKey, int problemKey, Date otherComplaintDate, String otherComplaintAgency, String otherComplaintWho, String otherComplaintWhoMore, String otherComplaintMode, String otherComplaintModeMore, String otherComplaintDetails, String otherComplaintRemark) {
		this.id = id;
		this.workerFinNumber = workerFinNumber;
		this.jobKey = jobKey;
		this.problemKey = problemKey;
		this.otherComplaintDate = otherComplaintDate;
		this.otherComplaintAgency = otherComplaintAgency;
		this.otherComplaintWho = otherComplaintWho;
		this.otherComplaintWhoMore = otherComplaintWhoMore;
		this.otherComplaintMode = otherComplaintMode;
		this.otherComplaintModeMore = otherComplaintModeMore;
		this.otherComplaintDetails = otherComplaintDetails;
		this.otherComplaintRemark = otherComplaintRemark;
	}
	
	//constructor without id
	public ProblemOtherComplaint(String workerFinNumber, int jobKey, int problemKey, Date otherComplaintDate, String otherComplaintAgency, String otherComplaintWho, String otherComplaintWhoMore, String otherComplaintMode, String otherComplaintModeMore, String otherComplaintDetails, String otherComplaintRemark) {
		this.workerFinNumber = workerFinNumber;
		this.jobKey = jobKey;
		this.problemKey = problemKey;
		this.otherComplaintDate = otherComplaintDate;
		this.otherComplaintAgency = otherComplaintAgency;
		this.otherComplaintWho = otherComplaintWho;
		this.otherComplaintWhoMore = otherComplaintWhoMore;
		this.otherComplaintMode = otherComplaintMode;
		this.otherComplaintModeMore = otherComplaintModeMore;
		this.otherComplaintDetails = otherComplaintDetails;
		this.otherComplaintRemark = otherComplaintRemark;
	}

	public int getId() {
		return id;
	}

	public String getWorkerFinNumber() {
		return workerFinNumber;
	}

	public int getJobKey() {
		return jobKey;
	}

	public int getProblemKey() {
		return problemKey;
	}

	public Date getOtherComplaintDate() {
		return otherComplaintDate;
	}

	public String getOtherComplaintAgency() {
		return otherComplaintAgency;
	}

	public String getOtherComplaintWho() {
		return otherComplaintWho;
	}

	public String getOtherComplaintWhoMore() {
		return otherComplaintWhoMore;
	}

	public String getOtherComplaintMode() {
		return otherComplaintMode;
	}

	public String getOtherComplaintModeMore() {
		return otherComplaintModeMore;
	}

	public String getOtherComplaintDetails() {
		return otherComplaintDetails;
	}

	public String getOtherComplaintRemark() {
		return otherComplaintRemark;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setWorkerFinNumber(String workerFinNumber) {
		this.workerFinNumber = workerFinNumber;
	}

	public void setJobKey(int jobKey) {
		this.jobKey = jobKey;
	}

	public void setProblemKey(int problemKey) {
		this.problemKey = problemKey;
	}

	public void setOtherComplaintDate(Date otherComplaintDate) {
		this.otherComplaintDate = otherComplaintDate;
	}

	public void setOtherComplaintAgency(String otherComplaintAgency) {
		this.otherComplaintAgency = otherComplaintAgency;
	}

	public void setOtherComplaintWho(String otherComplaintWho) {
		this.otherComplaintWho = otherComplaintWho;
	}

	public void setOtherComplaintWhoMore(String otherComplaintWhoMore) {
		this.otherComplaintWhoMore = otherComplaintWhoMore;
	}

	public void setOtherComplaintMode(String otherComplaintMode) {
		this.otherComplaintMode = otherComplaintMode;
	}

	public void setOtherComplaintModeMore(String otherComplaintModeMore) {
		this.otherComplaintModeMore = otherComplaintModeMore;
	}

	public void setOtherComplaintDetails(String otherComplaintDetails) {
		this.otherComplaintDetails = otherComplaintDetails;
	}

	public void setOtherComplaintRemark(String otherComplaintRemark) {
		this.otherComplaintRemark = otherComplaintRemark;
	}
}
