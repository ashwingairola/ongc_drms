var numOfRequests = document.getElementById('numOfRequests').value;

function filter()
{
    var val = document.getElementById('filter').value;
    if(val==='all')
        displayAllRequests();
    else if(val==='approved' || val==='pending' || val==='rejected')
        filterByStatus(val);
    else if(val==='bymonth')
        document.getElementById('monthselector').style.display = 'block';
    else if(val==='byyear')
        document.getElementById('yearselector').style.display = 'block';
}

function displayAllRequests()
{
    for(var i=0; i<numOfRequests; ++i)
    {
        document.getElementById('request'+i).style.display = 'block';
    }
}

function filterByStatus(val)
{
    if(val==='approved')
    {
        for(var i=0; i<numOfRequests; ++i)
        {
            var statusId = 'status'+i;
            var status = document.getElementById(statusId).innerHTML;
            if(status!=='APPROVED (To be dispatched)' && status!=='APPROVED (Data dispatched)')
            {
                document.getElementById('request'+i).style.display = 'none';
            }
            else
            {
                document.getElementById('request'+i).style.display = 'block';
            }
        }
    }
    else if(val==='pending')
    {
        for(var i=0; i<numOfRequests; ++i)
        {
            var statusId = 'status'+i;
            var status = document.getElementById(statusId).innerHTML;
            if(status==='APPROVED (To be dispatched)' || status==='APPROVED (Data dispatched)' || status==='REJECTED')
            {
                document.getElementById('request'+i).style.display = 'none';
            }
            else
            {
                document.getElementById('request'+i).style.display = 'block';
            }
        }
    }
    else if(val==='rejected')
    {
        for(var i=0; i<numOfRequests; ++i)
        {
            var statusId = 'status'+i;
            var status = document.getElementById(statusId).innerHTML;
            if(status!=='REJECTED')
            {
                document.getElementById('request'+i).style.display = 'none';
            }
            else
            {
                document.getElementById('request'+i).style.display = 'block';
            }
        }
    }
}

function filterByMonth()
{
    document.getElementById('monthselector').style.display = 'none';
    var monthSelected = document.getElementById('selectmonth').value;
    for(var i=0; i<numOfRequests; ++i)
    {
        var dateIssued = document.getElementById('dateIssued'+i).innerHTML;
        var monthIssued = dateIssued.substr(0,7);
        if(monthSelected!=monthIssued)
        {
            document.getElementById('request'+i).style.display = 'none';
        }
        else
        {
            document.getElementById('request'+i).style.display = 'block';
        }
    }
}

function filterByYear()
{
    document.getElementById('yearselector').style.display = 'none';
    var dateSelected = document.getElementById('selectyear').value;
    var yearSelected = dateSelected.substr(0,4);

    for(var i=0; i<numOfRequests; ++i)
    {
        var yearIssued = document.getElementById('dateIssued'+i).innerHTML.substr(0,4);
        if(yearSelected!=yearIssued)
        {
            document.getElementById('request'+i).style.display = 'none';
        }
        else
        {
            document.getElementById('request'+i).style.display = 'block';
        }
    }
}