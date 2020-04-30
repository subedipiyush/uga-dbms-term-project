<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- @author Tung Nguyen-->
<!-- TODO : This page should contain the code to display Match Data Explorer UI -->

<!-- see index_page_mock_ui.html (in the same folder as this page) for what to include in the page; the data presented in the UI are all mock data; assume they are provided by the server -->

<html>
<title>European Soccer Stats Explorer</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <style>
        .w3-container {
            margin-top:17px;
        }
         
        label:first-child { 
  			font-weight: bold;
		}
    </style>
</head>
<body>
    <div style="text-align: right; padding: 2%;">
        <a href="predictor_page_mock_ui.html">Go to Match Predictor</a>
    </div>
    <!-- javascript:void(0) -->
    <div class="w3-container">
        <h2>Search By</h2>

        <div class="w3-row">
            <a href="javascript:void(0)" onclick="openTab(event, 'Matches')">
                <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">Matches</div>
            </a>
            <a href="javascript:void(0)" onclick="openTab(event, 'Players')">
                <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">Players</div>
            </a>
            <a href="javascript:void(0)" onclick="openTab(event, 'Teams')">
                <div class="w3-third tablink w3-bottombar w3-hover-light-grey w3-padding">Teams</div>
            </a>
        </div>
		<!-- Matches Tab -->
        <div id="Matches" class="w3-container city" style="display:none">
			<form action="matches" method="post">
	            <table>
	                <tr>
	                    <td>
	                        <label for="country">Country: </label>
	                        <select id="country" required>
	                        	<c:forEach var="country" items="${listCountries.rows}">
	                            	<option value="${country}"><c:out value="${country}" /></option>
	                            </c:forEach>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <label for="league">League: </label>
	                        <select id="league" required disabled>
	                        	<c:forEach var="league" items="${listLeagues.rows}">
	                        		<!-- league.get(0) is the name of the league, and league.get(1) is the country of the league -->
	                            	<option class=="${fn:replace(${league.get(1)}, ' ', '_')}" value="${league.get(0)}"><c:out value="${league.get(0)}" /></option>
	                            </c:forEach>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <label for="team1">Team: </label>
	                        <select id="team1" required disabled>
	                        	<c:forEach var="team" items="${listTeams.rows}">
	                        		<!-- team.get(0) is the name of the team, and team.get(1) is the league of the team -->
	                            	<option class=="${fn:replace(${team.get(1)}, ' ', '_')}" value="${team.get(0)}"><c:out value="${team.get(0)}" /></option>
	                            </c:forEach>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <label for="team2">Team: </label>
	                        <select id="team2" required disabled>
	                        	<c:forEach var="team" items="${listTeams.rows}">
	                            	<option class=="${fn:replace(${team.get(1)}, ' ', '_')}" value="${team.get(0)}"><c:out value="${team.get(0)}" /></option>
	                            </c:forEach>
	                        </select>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <label for="where">Home or Away: </label>
	                        <input type="radio" id="home" name="loc" value="home">
	                        <label for="home">Home</label>
	                        <input type="radio" id="away" name="loc" value="away">
	                        <label for="away">Away</label>
	                        <input type="radio" id="neutral" name="loc" value="neutral">
	                        <label for="neutral">Neutral</label>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <label>Date: </label>
	                        <label for="from_date">From: </label>
	                        <input type="date" id="from_date" name="from_date">
	                        <label for="to_date">To: </label>
	                        <input type="date" id="to_date" name="to_date">
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <label>Match Result: </label>
	                        <input type="radio" id="won" name="result" value="won">
	                        <label for="won">Won</label>
	                        <input type="radio" id="lost" name="result" value="lost">
	                        <label for="lost">Lost</label>
	                        <input type="radio" id="draw" name="result" value="draw">
	                        <label for="draw">Draw</label>
	                    </td>
	                </tr>
	                <tr>
	                    <td>
	                        <label>Show: </label>
	                        <input type="checkbox" id="show_players" name="show_players" value="Players">
	                        <label for="show_players"> Players</label>
	                        <input type="checkbox" id="goals" name="goals" value="Goals" checked>
	                        <label for="goals"> Goals</label>
	                        <input type="checkbox" id="possession" name="possession" value="Possession" checked>
	                        <label for="possession"> Possession</label><br>
	                        <input type="checkbox" id="shots_on_target" name="shots_on_target" value="Shots On Target" checked>
	                        <label for="shots_on_target"> Shots On Target</label>
	                        <input type="checkbox" id="shots_off_target" name="shots_off_target" value="Shots Off Target" checked>
	                        <label for="shots_off_target"> Shots Off Target</label>
	                        <input type="checkbox" id="fouls_committed" name="fouls_committed" value="Fouls Committed" checked>
	                        <label for="fouls_committed"> Fouls Committed</label><br>
	                    </td>
	                </tr>
	            </table>
            	<button type="submit" onclick="showResults()">Search</button>
            </form>
        </div>
		<!-- Players Tab -->
        <div id="Players" class="w3-container city" style="display:none">
        	<form action="matches" method="post">
            	<input name="players" type="text" placeholder="Enter player's name" required>
            	<button type="submit" onclick="showResults()">Search</button>
            </form>
        </div>
		<!-- Teams Tab -->
        <div id="Teams" class="w3-container city" style="display:none">
        	<form action="teams" method="post">
            	<input name="teams" type="text" placeholder="Enter team's name" required>
            	<button type="submit" onclick="showResults()">Search</button>
            </form>
        </div>
    </div>
	<!-- Table -->
    <div class="results-table w3-container" id="results-table" style="display:none">
        <h4>Results (<c:out value="${table.size}" />)</h4>
        <table id="results-table" class="w3-table-all w3-responsive">
            <thead class="thead-light">
                <tr class="w3-red">
                	<c:forEach var="col" items="${table.cols}">
                    	<th scope="col"><c:out value="${col}" /></th>
                    </c:forEach>
                </tr>
            </thead>
            <tbody>
            	<c:forEach var="row" items="${table.rows}">
	            	<tr>
	               		<c:forEach var="value" items="${row}">
	                    	<td><c:out value="${value}" /></td>
						</c:forEach>
	                </tr>
	          	</c:forEach>
            </tbody>
        </table>
    </div>
</body>

<script>
    myFunction("country", "league");
    myFunction("league", "team1");

    function openTab(evt, cityName) {
        var i, x, tablinks;
        x = document.getElementsByClassName("city");
        for (i = 0; i < x.length; i++) {
            x[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablink");
        for (i = 0; i < x.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" w3-border-red", "");
        }
        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.firstElementChild.className += " w3-border-red";
    }

    function myFunction(attr1, attr2) {
    	//Get all options
        var allOptions = $("#" + attr2 + " option");
    	//Listner when an option is selected
        $("#" + attr1).change(function () {
        	//Clear the next select
            $("#" + attr2 + " option").remove()
            //Get the value of the selected option
            var classN = $("#" + attr1 + " option:selected").val().split(" ").join("_");
        	//Filter the next select's options
            var opts = allOptions.filter("." + classN);
        	//Add blank option into the next select
            $("#" + attr2).append(new Option("", ""));
        	//Add filered options into the next select
            $.each(opts, function (i, j) {
                $(j).appendTo("#" + attr2);
            });
            $("#" + attr2).attr("disabled", false);
            //For team2 if team1 is able
            if(attr2.localeCompare("team1") == 0) {
                var allOptions2 = $("#team2 option");
                var opts2 = allOptions2.filter("." + classN);
                $("#team2 option").remove()
                $("#team2").append(new Option("", ""));
                $.each(opts2, function (i, j) {
                    $(j).appendTo("#team2");
                });
                $("#team2").attr("disabled", false);
            }
        });
    }

    function showResults() {
        document.getElementById("results-table").style.display = "block";
    }
</script>

</html>