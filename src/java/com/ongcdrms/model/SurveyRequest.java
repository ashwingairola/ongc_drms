package com.ongcdrms.model;

import java.util.Date;

public class SurveyRequest
{
    private long requestId;
    private String userId, location, requestList, approver1Id, approver2Id, approver3Id, courierId, status;
    private boolean level1Approved, level2Approved, level3Approved, rejected, dispatched;
    private Date dateIssued, dateApproved1, dateApproved2, dateApproved3, dateDispatched;

    public long getRequestId() {
        return requestId;
    }

    public void setRequestId(long requestId) {
        this.requestId = requestId;
    }
    
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
    
    public String getRequestList() {
        return requestList;
    }

    public void setRequestList(String requestList) {
        this.requestList = requestList;
    }
    
    public boolean isLevel1Approved() {
        return level1Approved;
    }

    public void setLevel1Approved(boolean level1Approved) {
        this.level1Approved = level1Approved;
    }

    public boolean isLevel2Approved() {
        return level2Approved;
    }

    public void setLevel2Approved(boolean level2Approved) {
        this.level2Approved = level2Approved;
    }

    public boolean isLevel3Approved() {
        return level3Approved;
    }

    public void setLevel3Approved(boolean level3Approved) {
        this.level3Approved = level3Approved;
    }
    
    public boolean isRejected() {
        return rejected;
    }

    public void setRejected(boolean rejected) {
        this.rejected = rejected;
    }
    
    public Date getDateIssued() {
        return dateIssued;
    }

    public void setDateIssued(Date dateIssued) {
        this.dateIssued = dateIssued;
    }

    public Date getDateApproved1() {
        return dateApproved1;
    }

    public void setDateApproved1(Date dateApproved1) {
        this.dateApproved1 = dateApproved1;
    }

    public Date getDateApproved2() {
        return dateApproved2;
    }

    public void setDateApproved2(Date dateApproved2) {
        this.dateApproved2 = dateApproved2;
    }

    public Date getDateApproved3() {
        return dateApproved3;
    }

    public void setDateApproved3(Date dateApproved3) {
        this.dateApproved3 = dateApproved3;
    }

    public String getApprover1Id() {
        return approver1Id;
    }

    public void setApprover1Id(String approver1Id) {
        this.approver1Id = approver1Id;
    }

    public String getApprover2Id() {
        return approver2Id;
    }

    public void setApprover2Id(String approver2Id) {
        this.approver2Id = approver2Id;
    }

    public String getApprover3Id() {
        return approver3Id;
    }

    public void setApprover3Id(String approver3Id) {
        this.approver3Id = approver3Id;
    }

    public String getCourierId() {
        return courierId;
    }

    public void setCourierId(String courierId) {
        this.courierId = courierId;
    }

    public boolean isDispatched() {
        return dispatched;
    }

    public void setDispatched(boolean dispatched) {
        this.dispatched = dispatched;
    }

    public Date getDateDispatched() {
        return dateDispatched;
    }

    public void setDateDispatched(Date dateDispatched) {
        this.dateDispatched = dateDispatched;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
