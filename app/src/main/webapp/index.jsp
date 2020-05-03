<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> -->

<!-- @author Tung Nguyen-->
<html>
<title>European Soccer Stats Explorer</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

    <style>
        .tab-pane {
            width: 50%;
            margin-top: 20px;
        }

        .label-head {
            font-weight: bold;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-10">
                <h1>EU Soccer Data Explorer</h1>
            </div>
            <div class="col-md-2">
                <a href="/app/predictor">Go to Match Predictor</a>
            </div>
        </div>
        <div class="row">

        </div>
        <div class="row">
            <div class="col-md-10">
                <h3>Search By</h3>
            </div>
        </div>
        <ul class="nav nav-tabs nav-fill" id="search-tab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="matches-tab" data-toggle="tab" href="#Matches" role="tab"
                    aria-controls="Matches" aria-selected="true">Matches</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#Players" role="tab"
                    aria-controls="Players" aria-selected="false">Players</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="contact-tab" data-toggle="tab" href="#Teams" role="tab" aria-controls="Teams"
                    aria-selected="false">Teams</a>
            </li>
        </ul>
        <div class="tab-content" id="tabContent">

            <!-- Matches Tab -->
            <div id="Matches" class="tab-pane fade show active" aria-labelledby="matches-tab">
                <form action="matches" method="post">
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="country" class="label-head">Country </label>
                            <select class="form-control" id="country" required>
                                <c:forEach var="country" items="${params.countries}">
                                    <option value="${country.id}">
                                        <c:out value="${country.name}" />
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="league" class="label-head">League</label>
                            <select class="form-control" id="league" required>
                                <!-- league.get(0) is the name of the league, and league.get(1) is the country of the league -->
                                <c:forEach var="league" items="${params.leagues}">
                                    <option class="${league.parent}" value="${league.id}">
                                        <c:out value="${league.name}" />
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="team1" class="label-head">Team 1 </label>
                            <select class="form-control" id="team1" required>
                                <!-- team.get(0) is the name of the team, and team.get(1) is the league of the team -->
                                <c:forEach var="team" items="${params.teams}">
                                    <option class=="${team.parent}" value="${team.id}">
                                        <c:out value="${team.name}" />
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="team2" class="label-head">Team 2 </label>
                            <select class="form-control" id="team2" required>
                                <c:forEach var="team" items="${params.teams}">
                                    <option class=="${team.parent}" value="${team.id}">
                                        <c:out value="${team.name}" />
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3">
                            <label for="where" class="label-head">Home or Away</label>
                        </div>
                        <div class="col-md-9">
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" id="home" name="loc" value="home" class="custom-control-input"
                                    checked>
                                <label class="custom-control-label" for="home">Home</label>
                            </div>
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" id="away" name="loc" value="away" class="custom-control-input">
                                <label class="custom-control-label" for="away">Away</label>
                            </div>
                            <div class="custom-control custom-radio custom-control-inline">
                                <input type="radio" id="neutral" name="loc" value="neutral"
                                    class="custom-control-input">
                                <label class="custom-control-label" for="neutral">Neutral</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-6">
                            <div>
                                <label for="from_date" class="form-control-label label-head">From </label>
                                <input type="date" id="from_date" name="from_date" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div>
                                <label for="to_date" class="form-control-label label-head">To </label>
                                <input type="date" id="to_date" name="to_date" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-3">
                            <label class="label-head">Match Result</label>
                        </div>
                        <div class="col-md-9">
                            <div class="custom-control custom-checkbox custom-control-inline">
                                <input type="checkbox" id="won" name="result_type" value="won"
                                    class="custom-control-input" checked>
                                <label class="custom-control-label" for="won">Won</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control-inline">
                                <input type="checkbox" id="lost" name="result_type" value="lost"
                                    class="custom-control-input" checked>
                                <label class="custom-control-label" for="lost">Lost</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control-inline">
                                <input type="checkbox" id="draw" name="result_type" value="draw"
                                    class="custom-control-input" checked>
                                <label class="custom-control-label" for="draw">Draw</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col-md-12">
                            <label class="label-head">Show</label>
                        </div>
                        <div class="col-md-9">
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="show_players" name="show_players" value="Players"
                                    class="custom-control-input">
                                <label class="custom-control-label" for="show_players">Players</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="goals" name="goals" value="Goals"
                                    class="custom-control-input" checked>
                                <label class="custom-control-label" for="goals">Goals</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="possession" name="possession" value="Possession"
                                    class="custom-control-input" checked>
                                <label class="custom-control-label" for="possession">Possession</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="shots_on_target" name="shots_on_target"
                                    value="Shots On Target" class="custom-control-input" checked>
                                <label class="custom-control-label" for="shots_on_target">Shots On Target</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="shots_off_target" name="shots_off_target"
                                    value="Shots Off Target" class="custom-control-input" checked>
                                <label class="custom-control-label" for="shots_off_target">Shots Off Target</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="fouls_committed" name="fouls_committed"
                                    value="Fouls Committed" class="custom-control-input" checked>
                                <label class="custom-control-label" for="fouls_committed">Fouls Committed</label>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary" onclick="showResults()">Search</button>
                </form>
            </div>
            <!-- Players Tab -->
            <div id="Players" class="tab-pane fade" aria-labelledby="players-tab">
                <form action="players" method="post">
                    <input class="form-control" id="player_name" name="player_name" type="text" placeholder="Enter player's name" required>
                    <button type="submit" class="btn btn-primary" onclick="showResults()">Search</button>
                </form>
            </div>
            <!-- Teams Tab -->
            <div id="Teams" class="tab-pane fade" aria-labelledby="teams-tab">
                <form action="teams" method="post">
                    <input class="form-control" id="team_name" name="team_name" type="text" placeholder="Enter team's name" required>
                    <button type="submit" class="btn btn-primary" onclick="showResults()">Search</button>
                </form>
            </div>
        </div>

        <!-- Results -->
        <c:if test="${not empty results}">
            <div class="row">
                <div class="col-md-12 my-2">
                    <h4> Results (${results.size})</h4>
                    <div class="results-table">
                        <table id="results-table" class="table table-hover table-fixed">
                            <thead class="thead-light">
                                <tr>
                                    <c:forEach items="${results.cols}" var="col">
                                        <th scope="col">${col}</th>
                                    </c:forEach>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${results.rows}" var="row">
                                    <tr>
                                        <c:forEach items="${row}" var="rowItem">
                                            <td>${rowItem}</td>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

        </c:if>

</body>

<script>

    // setDependency("country", "league");
    // setDependency("league", "team1");

    function setDependency(attr1, attr2) {
        //Get all options
        var allOptions = $("#" + attr2 + " option");
        //Listner when an option is selected
        $("#" + attr1).change(function () {
            //Clear the next select
            $("#" + attr2 + " option").remove()
            //Get the value of the selected option
            var classN = $("#" + attr1 + " option:selected").val();
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
            if (attr2.localeCompare("team1") == 0) {
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