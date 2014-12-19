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
public class ProblemWicaClaim {
	private int id;
	private String workerFinNumber;
	private int jobKey;
	private int problmeKey;
	private Date wicaClaimDate;
	private String wicaReferenceNumber;
	private String wicaInsurer;
	private String wicaPolicyNumber;
	private String wicaClaimReason;
	private String wicaClaimRemark;

	//constructor with id
	public ProblemWicaClaim(int id, String workerFinNumber, int jobKey, int problmeKey, Date wicaClaimDate, String wicaReferenceNumber, String wicaInsurer, String wicaPolicyNumber, String wicaClaimReason, String wicaClaimRemark) {
		this.id = id;
		this.workerFinNumber = workerFinNumber;
		this.jobKey = jobKey;
		this.problmeKey = problmeKey;
		this.wicaClaimDate = wicaClaimDate;
		this.wicaReferenceNumber = wicaReferenceNumber;
		this.wicaInsurer = wicaInsurer;
		this.wicaPolicyNumber = wicaPolicyNumber;
		this.wicaClaimReason = wicaClaimReason;
		this.wicaClaimRemark = wicaClaimRemark;
	}
	
	//constructor without id
	public ProblemWicaClaim(String workerFinNumber, int jobKey, int problmeKey, Date wicaClaimDate, String wicaReferenceNumber, String wicaInsurer, String wicaPolicyNumber, String wicaClaimReason, String wicaClaimRemark) {
		this.workerFinNumber = workerFinNumber;
		this.jobKey = jobKey;
		this.problmeKey = problmeKey;
		this.wicaClaimDate = wicaClaimDate;
		this.wicaReferenceNumber = wicaReferenceNumber;
		this.wicaInsurer = wicaInsurer;
		this.wicaPolicyNumber = wicaPolicyNumber;
		this.wicaClaimReason = wicaClaimReason;
		this.wicaClaimRemark = wicaClaimRemark;
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

	public int getProblmeKey() {
		return problmeKey;
	}

	public Date getWicaClaimDate() {
		return wicaClaimDate;
	}

	public String getWicaReferenceNumber() {
		return wicaReferenceNumber;
	}

	public String getWicaInsurer() {
		return wicaInsurer;
	}

	public String getWicaPolicyNumber() {
		return wicaPolicyNumber;
	}

	public String getWicaClaimReason() {
		return wicaClaimReason;
	}

	public String getWicaClaimRemark() {
		return wicaClaimRemark;
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

	public void setProblmeKey(int problmeKey) {
		this.problmeKey = problmeKey;
	}

	public void setWicaClaimDate(Date wicaClaimDate) {
		this.wicaClaimDate = wicaClaimDate;
	}

	public void setWicaReferenceNumber(String wicaReferenceNumber) {
		this.wicaReferenceNumber = wicaReferenceNumber;
	}

	public void setWicaInsurer(String wicaInsurer) {
		this.wicaInsurer = wicaInsurer;
	}

	public void setWicaPolicyNumber(String wicaPolicyNumber) {
		this.wicaPolicyNumber = wicaPolicyNumber;
	}

	public void setWicaClaimReason(String wicaClaimReason) {
		this.wicaClaimReason = wicaClaimReason;
	}

	public void setWicaClaimRemark(String wicaClaimRemark) {
		this.wicaClaimRemark = wicaClaimRemark;
	}
}
