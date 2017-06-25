package model;

import java.sql.*;
import java.util.*;

public class DBManager
{
    private static final String DBURL = "jdbc:mysql://localhost:3306/ongc_drms";
    private static final String DBUSER = "root";
    private static final String DBPASSWORD = "password";
    
    static
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    
    public static User getUserDetails(String username)
    {
        User user = null;
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement("SELECT * FROM employee WHERE userid=?");
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if(rs.first())
            {
                user = new User();
                user.setUserId(rs.getString("userid"));
                user.setFirstName(rs.getString("firstname"));
                user.setMiddleName(rs.getString("midname"));
                user.setLastName(rs.getString("surname"));
                user.setPhno(rs.getString("phone"));
                user.setDesignation(rs.getString("designation"));
                user.setLocation(rs.getString("location"));
                user.setRole(rs.getString("role"));
            }
            con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return user;
    }
    
    public static User getUser(String userid)
    {
        User user = null;
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement("SELECT passwd, role FROM employee where userid=?");
            st.setString(1, userid);
            ResultSet rs = st.executeQuery();
            if(rs.first())
            {
                user = new User();
                user.setPassword(rs.getString("passwd"));
                user.setRole(rs.getString("role"));
            }
            con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return user;
    }
    
    public static boolean addRequest(SurveyRequest surveyRequest)        // This method adds a request made by a SENDER to the request
    {                                                                               // database.
        boolean flag = false;
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement("INSERT INTO request"
                    + "(request_id, userid, location, request_list, date_issued, status)"
                    + " VALUES(?,?,?,?,?,?)");
            st.setString(1, surveyRequest.getRequestId()+"");
            st.setString(2, surveyRequest.getUserId());
            st.setString(3, surveyRequest.getLocation());
            st.setString(4, surveyRequest.getRequestList());
            st.setDate(5, new java.sql.Date((surveyRequest.getDateIssued()).getTime()));
            st.setString(6, surveyRequest.getStatus());
            st.execute();
            con.close();
            flag = true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return flag;
    }
    
    public static ArrayList<SurveyRequest> getSurveyRequests(String location, String role) //This method fetches all the pending survey requests
    {                                                                                               //at an APPROVER's level.
        ArrayList<SurveyRequest> requestList = null;
        SurveyRequest surveyRequest = null;
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            
            String sql, levelApproved;
            if(role.equalsIgnoreCase("approver1"))
                levelApproved = "is_level1_approved";
            else if(role.equalsIgnoreCase("approver2"))
                levelApproved = "is_level2_approved";
            else
                levelApproved = "is_level3_approved";
            
            if(location.equalsIgnoreCase("GEOPIC, Dehradun"))
            {
                if(levelApproved.equalsIgnoreCase("is_level1_approved"))
                    sql = "SELECT * FROM request WHERE " + levelApproved + "=false AND is_rejected=false";
                else if(levelApproved.equalsIgnoreCase("is_level2_approved"))
                    sql = "SELECT * FROM request WHERE is_level1_approved=true AND " + levelApproved + "=false AND is_rejected=false";
                else
                    sql = "SELECT * FROM request WHERE is_level1_approved=true AND is_level2_approved=true AND " +
                            levelApproved + "=false AND is_rejected=false";
            }
            else
                sql = "SELECT * FROM request WHERE location='" + location + "' AND " + levelApproved + "=false AND is_rejected=false";
            
            sql += " ORDER BY date_issued DESC";
            
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            requestList = new ArrayList<>();
            while(rs.next())
            {
                surveyRequest = new SurveyRequest();
                surveyRequest.setRequestId(Long.parseLong(rs.getString("request_id")));
                surveyRequest.setUserId(rs.getString("userid"));
                surveyRequest.setLocation(rs.getString("location"));
                surveyRequest.setRequestList(rs.getString("request_list"));
                surveyRequest.setLevel1Approved(rs.getBoolean("is_level1_approved"));
                surveyRequest.setLevel2Approved(rs.getBoolean("is_level2_approved"));
                surveyRequest.setLevel3Approved(rs.getBoolean("is_level3_approved"));
                surveyRequest.setRejected(rs.getBoolean("is_rejected"));
                surveyRequest.setDateIssued(rs.getDate("date_issued"));
                surveyRequest.setDateApproved1(rs.getDate("date_approved1"));
                surveyRequest.setDateApproved2(rs.getDate("date_approved2"));
                surveyRequest.setDateApproved3(rs.getDate("date_approved3"));
                requestList.add(surveyRequest);
            }
            con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return requestList;
    }
    
    public static boolean handleRequest(String requestId, boolean approved, boolean rejected, String role, String userId)
    {
        String levelApproved, approverId, status;
        if(role.equalsIgnoreCase("approver1"))
        {
            levelApproved = "is_level1_approved";
            approverId = "approver1_id";
            status = "PENDING (To be approved approved by GMS)";
        }
        else if(role.equalsIgnoreCase("approver2"))
        {
            levelApproved = "is_level2_approved";
            approverId = "approver2_id";
            status = "PENDING (To be approved by HOI, GEOPIC, Dehradun)";
        }
        else
        {
            levelApproved = "is_level3_approved";
            approverId = "approver3_id";
            status = "APPROVED (To be dispatched)";
        }
        
        boolean flag = false;
        if(rejected)
        {
            levelApproved = "is_rejected";
            flag = rejectRequest(requestId, levelApproved, approverId, userId, status);
        }
        else if(approved)
        {
            flag = approveRequest(requestId, levelApproved, approverId, userId, status);
        }
        return flag;
    }
    
    public static boolean approveRequest(String requestId, String levelApproved, String approverId, String userId, String status)     // This method UPDATES a pending request. The request is either
    {                                                                               // APPROVED at the APPROVER's level, or REJECTED, following which
        boolean flag = false;                                                       // it no longer moves up the APPROVER heirarchy.
        try
        {
            String dateApproved = (levelApproved.equalsIgnoreCase("is_level1_approved"))?"date_approved1"
                    :(levelApproved.equalsIgnoreCase("is_level2_approved"))?"date_approved2"
                    :"date_approved3";
            String query = "UPDATE request SET " + levelApproved + "=true, " + dateApproved + "=?, " +
                    approverId + "=?, status=? WHERE request_id=?";
            
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement(query);
            st.setDate(1, new java.sql.Date(new java.util.Date().getTime()));
            st.setString(2, userId);
            st.setString(3, status);
            st.setString(4, requestId);
            st.executeUpdate();
            con.close();
            flag = true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return flag;
    }
    
    public static boolean rejectRequest(String requestId, String levelApproved, String approverId, String userId, String status)     // This method UPDATES a pending request. The request is either
    {                                                                               // APPROVED at the APPROVER's level, or REJECTED, following which
        boolean flag = false;                                                       // it no longer moves up the APPROVER heirarchy.
        try
        {
            status = "REJECTED";
            String query = "UPDATE request SET " + levelApproved + "=true, "
                    + approverId + "=?, status=? WHERE request_id=?";
            
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, userId);
            st.setString(2, status);
            st.setString(3, requestId);
            st.executeUpdate();
            con.close();
            flag = true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return flag;
    }
    
    public static ArrayList<SurveyRequest> getHistory(String userId)        // This method fetches ALL the survey requests that the SENDER has ever made,
    {                                                                       // whether they have been APPROVED, are still PENDING or have been REJECTED.
        ArrayList<SurveyRequest> history = null;
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement("SELECT * FROM request WHERE userid=?");
            st.setString(1, userId);
            ResultSet rs = st.executeQuery();
            history = new ArrayList<>();
            while(rs.next())
            {
                SurveyRequest surveyRequest = new SurveyRequest();
                surveyRequest.setRequestId(Long.parseLong(rs.getString("request_id")));
                surveyRequest.setUserId(rs.getString("userid"));
                surveyRequest.setRequestList(rs.getString("request_list"));
                surveyRequest.setLocation(rs.getString("location"));
                surveyRequest.setLevel1Approved(rs.getBoolean("is_level1_approved"));
                surveyRequest.setLevel2Approved(rs.getBoolean("is_level2_approved"));
                surveyRequest.setLevel3Approved(rs.getBoolean("is_level3_approved"));
                surveyRequest.setRejected(rs.getBoolean("is_rejected"));
                surveyRequest.setDateIssued(rs.getDate("date_issued"));
                surveyRequest.setStatus(rs.getString("status"));
                history.add(surveyRequest);
            }
            con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return history;
    }
    
    public static ArrayList<SurveyRequest> getApprovedRequests(String userId)
    {                                                                               // This method gets all the survey requests that have been APPROVED
        ArrayList<SurveyRequest> approvedRequests = null;                           // at ALL levels. This is displayed to the SENDER only.
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement("SELECT * FROM request"
                    + " WHERE userid=? AND is_level3_approved=true");
            st.setString(1, userId);
            ResultSet rs = st.executeQuery();
            approvedRequests = new ArrayList<>();
            while(rs.next())
            {
                SurveyRequest surveyRequest = new SurveyRequest();
                surveyRequest.setRequestId(Long.parseLong(rs.getString("request_id")));
                surveyRequest.setUserId(rs.getString("userid"));
                surveyRequest.setRequestList(rs.getString("request_list"));
                surveyRequest.setLocation(rs.getString("location"));
                surveyRequest.setLevel1Approved(rs.getBoolean("is_level1_approved"));
                surveyRequest.setLevel2Approved(rs.getBoolean("is_level2_approved"));
                surveyRequest.setLevel3Approved(rs.getBoolean("is_level3_approved"));
                surveyRequest.setRejected(rs.getBoolean("is_rejected"));
                surveyRequest.setDateIssued(rs.getDate("date_issued"));
                surveyRequest.setDateApproved3(rs.getDate("date_approved3"));
                surveyRequest.setStatus(rs.getString("status"));
                approvedRequests.add(surveyRequest);
            }
            con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return approvedRequests;
    }
    
    public static ArrayList<SurveyRequest> getApproverHistory(String location, String role, String userId)    // This method returns the entire history
    {                                                                                                   // of the APPROVER.
        ArrayList<SurveyRequest> approverHistory = null;
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            
            String approverId;
            if(role.equalsIgnoreCase("approver1"))
                approverId = "approver1_id";
            else if(role.equalsIgnoreCase("approver2"))
                approverId = "approver2_id";
            else
                approverId = "approver3_id";
            
            String sql = "SELECT * FROM request WHERE " + approverId + "=" + userId;
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            approverHistory = new ArrayList<>();
            while(rs.next())
            {
                SurveyRequest surveyRequest = new SurveyRequest();
                surveyRequest.setRequestId(Long.parseLong(rs.getString("request_id")));
                surveyRequest.setUserId(rs.getString("userid"));
                surveyRequest.setLocation(rs.getString("location"));
                surveyRequest.setRequestList(rs.getString("request_list"));
                surveyRequest.setLevel1Approved(rs.getBoolean("is_level1_approved"));
                surveyRequest.setLevel2Approved(rs.getBoolean("is_level2_approved"));
                surveyRequest.setLevel3Approved(rs.getBoolean("is_level3_approved"));
                surveyRequest.setRejected(rs.getBoolean("is_rejected"));
                surveyRequest.setDateIssued(rs.getDate("date_issued"));
                surveyRequest.setDateApproved1(rs.getDate("date_approved1"));
                surveyRequest.setDateApproved2(rs.getDate("date_approved2"));
                surveyRequest.setDateApproved3(rs.getDate("date_approved3"));
                surveyRequest.setStatus(rs.getString("status"));
                approverHistory.add(surveyRequest);
            }
            con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return approverHistory;
    }
    
    public static ArrayList<SurveyRequest> getDispatchableRequests()
    {
        ArrayList<SurveyRequest> requestList = null;
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement("SELECT * FROM request WHERE is_level3_approved=true"
                    + " AND is_dispatched=false");            
            ResultSet rs = st.executeQuery();
            requestList = new ArrayList<>();
            while(rs.next())
            {
                SurveyRequest surveyRequest = new SurveyRequest();
                surveyRequest.setRequestId(Long.parseLong(rs.getString("request_id")));
                surveyRequest.setUserId(rs.getString("userid"));
                surveyRequest.setRequestList(rs.getString("request_list"));
                surveyRequest.setLocation(rs.getString("location"));
                surveyRequest.setDateIssued(rs.getDate("date_issued"));
                requestList.add(surveyRequest);
            }
            con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return requestList;
    }
    
    public static boolean dispatchRequest(String requestId, String courierId)
    {
        boolean flag = false;
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement("UPDATE request SET is_dispatched=true,"
                    + " courier_id=?, date_dispatched=?, status='APPROVED (Data dispatched)'"
                    + " WHERE request_id=?");
            st.setString(1, courierId);
            st.setDate(2, new java.sql.Date(new java.util.Date().getTime()));
            st.setString(3, requestId);
            st.execute();
            flag = true;
            con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return flag;
    }
    
    // Following are the methods for the ADMIN
    
    public static boolean addUser(String userId, String password, String firstName, String middleName, String lastName,
            String phone, String designation, String location, String role)
    {
        boolean flag = false;
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement("INSERT INTO employee VALUES (?,?,?,?,?,?,?,?,?)");
            st.setString(1, userId);
            st.setString(2, password);
            st.setString(3, firstName);
            st.setString(4, middleName);
            st.setString(5, lastName);
            st.setString(6, phone);
            st.setString(7, designation);
            st.setString(8, location);
            st.setString(9, role);
            st.executeUpdate();
            con.close();
            flag = true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return flag;
    }
    
    public static boolean deleteUser(String userId)
    {
        boolean flag = false;
        try
        {
            Connection con = DriverManager.getConnection(DBURL, DBUSER, DBPASSWORD);
            PreparedStatement st = con.prepareStatement("DELETE FROM employee where userid=?");
            st.setString(1, userId);
            st.executeUpdate();
            con.close();
            flag = true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return flag;
    }
}
