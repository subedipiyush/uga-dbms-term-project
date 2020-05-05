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

        .results-table {
            overflow-y: auto;
            overflow-x: auto;
            max-height: 300px;
        }

        .results-table thead th {
            position: sticky;
            top: 0;
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
                            <select class="form-control" id="country" name="country">
                                <option value="" >
                                    <c:out value=""  />
                                </option>
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
                            <select class="form-control" id="league" name="league">
                                <option value="" >
                                    <c:out value=""  />
                                </option>
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
                            <select class="form-control" id="team1" name="team1">
                                <option value="" >
                                    <c:out value=""  />
                                </option>
                                <!-- team.get(0) is the name of the team, and team.get(1) is the league of the team -->
                                <c:forEach var="team" items="${params.teams}">
                                    <option class="${team.parent}" value="${team.id}">
                                        <c:out value="${team.name}" />
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="team2" class="label-head">Team 2 </label>
                            <select class="form-control" id="team2" name="team2">
                                <option value="" >
                                    <c:out value=""  />
                                </option>
                                <c:forEach var="team" items="${params.teams}">
                                    <option class="${team.parent}" value="${team.id}">
                                        <c:out value="${team.name}" />
                                    </option>
                                </c:forEach>
                            </select>
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
                                <input type="checkbox" id="won" name="won" 
                                    class="custom-control-input" value="on"  checked>
                                <label class="custom-control-label" for="won">Won</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control-inline">
                                <input type="checkbox" id="lost" name="lost" 
                                    class="custom-control-input" value="on"  checked>
                                <label class="custom-control-label" for="lost">Lost</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control-inline">
                                <input type="checkbox" id="draw" name="draw" 
                                    class="custom-control-input" value="on"  checked>
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
                                <input type="checkbox" id="goals" name="goals"
                                     class="custom-control-input" value="on"  checked>
                                <label class="custom-control-label" for="goals">Goals</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="possession" name="possession" 
                                     class="custom-control-input" value="on"  checked>
                                <label class="custom-control-label" for="possession">Possession</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="shots_on_target" name="shots_on_target"
                                     class="custom-control-input" value="on"  checked>
                                <label class="custom-control-label" for="shots_on_target">Shots On Target</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="shots_off_target" name="shots_off_target"
                                     class="custom-control-input" value="on"  checked>
                                <label class="custom-control-label" for="shots_off_target">Shots Off Target</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="corner" name="corner"
                                     class="custom-control-input" value="on"  checked>
                                <label class="custom-control-label" for="corner">Corner</label>
                            </div>
                            <div class="custom-control custom-checkbox custom-control">
                                <input type="checkbox" id="fouls_committed" name="fouls_committed"
                                     class="custom-control-input" value="on"  checked>
                                <label class="custom-control-label" for="fouls_committed">Fouls Committed</label>
                            </div>
                        </div>
                    </div>
                    <button id="search_matches_btn" class="btn btn-primary">Search</button>
                </form>
            </div>
            <!-- Players Tab -->
            <div id="Players" class="tab-pane fade" aria-labelledby="players-tab">
                <form action="players" method="post">
                    <input class="form-control" id="player_name" name="player_name" type="text" placeholder="Enter player's name" required>
                    <button id="search_players_btn" class="btn btn-primary">Search</button>
                </form>
            </div>
            <!-- Teams Tab -->
            <div id="Teams" class="tab-pane fade" aria-labelledby="teams-tab">
                <form action="teams" method="post">
                    <input class="form-control" id="team_name" name="team_name" type="text" placeholder="Enter team's name" required>
                    <button id="search_teams_btn" class="btn btn-primary">Search</button>
                </form>
            </div>
        </div>

        <!-- Results -->
        <div id="results">
            <div class="row">
                <div class="col-md-12 my-2">
                    <h4> Results <span id="num_of_results"></span></h4>
                    <div class="results-table">
                        <table id="results-table" class="table table-hover table-fixed">
                        </table>
                    </div>
                </div>
            </div>
        </div>

</body>

<script>

    var allOptions = {};

    hide("results");

    setDependency("country", ["league"]);
    setDependency("league", ["team1", "team2"]);

    selectFirst("country");

    function setDependency(parent, dependents) {

        //Get all options
        for (let i=0; i < dependents.length; i++) {
            allOptions[dependents[i]] = $("#" + dependents[i] + " option");
        }

        //Listner when an option is selected
        $("#" + parent).change(function() {
            filterOptions(parent, dependents)
        });
    }

    function filterOptions(parent, dependents) {

        //Get the value of the selected option
        let classN = $("#" + parent + " option:selected").val();

        for (let i=0; i < dependents.length; i++) {

            let dependent = dependents[i];

            //Clear the next select
            $("#" + dependent + " option").remove();

            let opts = allOptions[dependent];
            if (classN !== "") {
                opts = opts.filter("." + classN);
            }

            //Add filered options into the next select
            $.each(opts, function (i, j) {
                $(j).appendTo("#" + dependent);
            });

            if (opts) {
                selectFirst(dependent);
            }

        }
        
    }

    function selectFirst(elem) {

        let allOptions = $("#" + elem + " option");

        $("#" + elem).val(allOptions[0] && allOptions[0].value);

        $("#" + elem).change();
    }

    function show(elem) {
        $("#" + elem).show();
    }
    function hide(elem) {
        $("#" + elem).hide();
    }
    
    $("#search_matches_btn").click(function (e) {
        e.preventDefault();

        let initialText = e.currentTarget.textContent;

        e.currentTarget.textContent = "Searching...";

        search("matches", {
            "country" : $("#country").val(),
            "league" : $("#league").val(),
            "team1" : $("#team1").val(),
            "team2" : $("#team2").val(),
            "from_date" : $("#from_date").val(),
            "to_date" : $("#to_date").val(),
            "won" : $("#won").is(':checked'),
            "lost" : $("#lost").is(':checked'),
            "draw" : $("#draw").is(':checked'),
            "goals" : $("#goals").is(':checked'),
            "possession" : $("#possession").is(':checked'),
            "shots_on_target" : $("#shots_on_target").is(':checked'),
            "shots_off_target" : $("#shots_off_target").is(':checked'),
            "corner" : $("#corner").is(':checked'),
            "fouls_committed" : $("#fouls_committed").is(':checked')
        }, () => {
            e.currentTarget.textContent = initialText;
        });

    });

    $("#search_players_btn").click(function (e) {
        e.preventDefault();

        let initialText = e.currentTarget.textContent;

        e.currentTarget.textContent = "Searching...";

        search("players", {
            "player_name" : $("#player_name").val()
        }, () => {
            e.currentTarget.textContent = initialText;
        });

    });

    $("#search_teams_btn").click(function (e) {
        e.preventDefault();

        let initialText = e.currentTarget.textContent;

        e.currentTarget.textContent = "Searching...";

        search("teams", {
            "team_name" : $("#team_name").val()
        }, () => {
            e.currentTarget.textContent = initialText;
        });

    });


    function search(endPoint, params, callback) {

        $.post(endPoint, params, function (tableData) {
            displayTable(tableData);
        })
        .fail(function (error) {
            console.error(error);
        })
        .always(function () {
            callback();
        })

    }

    function displayTable(tableData) {

        hide("results");
        if (tableData && tableData.rows && tableData.cols) {

            let resultsTbl = $("#results-table");

            $("#results-table tr").remove();

            let header = $("<thead class='thead-light' />");

            let tr = $("<tr />");
            
            for (let i=0; i < tableData.cols.length; i++) {
                tr.append($("<th scope='col' />").html(tableData.cols[i]));
            }

            tr.appendTo(header);
            header.appendTo(resultsTbl);

            let tbody = $("<tbody />");
            for (let i=0; i < tableData.rows.length; i++) {
                var tbTr = $("<tr />");
                for (let j=0; j < tableData.rows[i].length; j++) {
                    tbTr.append($("<td />").html(tableData.rows[i][j]));
                }
                tbTr.appendTo(tbody);
            }

            tbody.appendTo(resultsTbl);

            $("#num_of_results").empty();
            $("#num_of_results").append("(" + tableData.rows.length + ")");

            show("results");
        }

    }

</script>

</html>