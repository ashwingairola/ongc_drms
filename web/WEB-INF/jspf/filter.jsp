<%-- 
    Document   : filter
    Created on : Jun 11, 2017, 5:12:39 AM
    Author     : Ashwin Gairola
--%>

<div id="selectfilter">
    <b>You may select a filter here:</b>
    <select id="filter">
        <option value="all">All</option>
        <option value="approved">Approved</option>
        <option value="pending">Pending</option>
        <option value="rejected">Rejected</option>
        <option value="bymonth">By Month</option>
        <option value="byyear">By Year</option>
    </select>
    <button type="button" onclick="filter()">Filter</button>
</div>

<div id="monthselector">
    <div class="selectorcontent">
        <div style="margin-bottom: 20px">
            <span onclick="document.getElementById('monthselector').style.display = 'none';" class="closecalendar">&times;</span>
        </div>
        <p><b>Filter requests by month</b></p>
        <input type="month" id="selectmonth">
        <button onclick="filterByMonth()">Filter</button>
    </div>
</div>

<div id="yearselector">
    <div class="selectorcontent">
        <div style="margin-bottom: 20px">
            <span onclick="document.getElementById('yearselector').style.display = 'none';" class="closecalendar">&times;</span>
        </div>
        <p><b>Filter requests by year</b></p>
        <input type="month" id="selectyear">
        <button onclick="filterByYear()">Filter</button>
    </div>
</div>