<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- @author Anthony Holevinski -->
<!-- TODO : This page should contain the code to display Match Prediction UI -->


<html>

<head>
    <title>Match Predictor</title>
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
        .label-head {
            font-weight: bold;
        }

        .card-title {
            background-size: contain;
            background-color: lavender;
            padding: 20;
            text-align: center;
        }
    </style>

</head>

<body>

    <div class="container">
        <form action="predictor" method="post">

            <div class="row">
                <div class="col-md-10">
                    <h1 class="text-center">EU Soccer Match Predictor</h1>
                </div>
                <div class="col-md-2">
                    <a href="/app/">Go to Explorer View</a>
                </div>
            </div>
            <div class="row" style="margin-top: 50px;">
                <div class="col-md-5">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Select Team 1</h5>
                            <div class="form-row">
                                <div class="form-group col-md-12">
                                    <label for="country" class="label-head">Country </label>
                                    <select class="form-control" id="country1" required>
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
                                    <select class="form-control" id="league1" required>
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
                                <div class="form-group col-md-12">
                                    <label for="team1" class="label-head">Team 1 </label>
                                    <select class="form-control" id="team1" name="team1_id" required>
                                        <!-- team.get(0) is the name of the team, and team.get(1) is the league of the team -->
                                        <c:forEach var="team" items="${params.teams}">
                                            <option class="${team.parent}" value="${team.id}">
                                                <c:out value="${team.name}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div id="team1_winner_text" class="form-row">
                                <div class="mx-auto" style="width: 200px;">
                                    <h2 style="color: chartreuse">WINNER</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-2" style="padding: 5rem">
                    <h5>Vs</h5>
                </div>
                <div class="col-md-5">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Select Team 2</h5>
                            <div class="form-row">
                                <div class="form-group col-md-12">
                                    <label for="country" class="label-head">Country </label>
                                    <select class="form-control" id="country2" required>
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
                                    <select class="form-control" id="league2" required>
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
                                    <label for="team1" class="label-head">Team</label>
                                    <select class="form-control" id="team2" name="team2_id" required>
                                        <!-- team.get(0) is the name of the team, and team.get(1) is the league of the team -->
                                        <c:forEach var="team" items="${params.teams}">
                                            <option class="${team.parent}" value="${team.id}">
                                                <c:out value="${team.name}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div id="team2_winner_text" class="form-row">
                                <div class="mx-auto" style="width: 200px;">
                                    <h2 style="color: chartreuse">WINNER</h2>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mx-auto" style="width: 98px;">
                <button id="predict-btn" name="predict-btn" class="btn btn-primary">Predict</button>
            </div>
            
            <div id="tie_text" class="mx-auto form-row" style="width: 200px;">
                <h2 style="color: chocolate">We think it will be a tie</h2>
            </div>
        </form>
    </div>

</body>

<script type="text/javascript">

    hidePrediction();

    function hidePrediction() {
        hide ("team1_winner_text");
        hide ("team2_winner_text");
        hide ("tie_text");
    }

    $("#team1").change(function (e) {
        hidePrediction();
    });
    $("#team2").change(function (e) {
        hidePrediction();
    });

    $("#predict-btn").click(function (e) {
        e.preventDefault();

        let initialText = e.currentTarget.textContent;

        e.currentTarget.textContent = "Evaluating..."

        let team1 = $("#team1").val();
        let team2 = $("#team2").val();

        $.post('predictor', {
            "team1_id" : team1,
            "team2_id" : team2
        }, function(response) { 
            if (response) {
                if (response === "1") {
                    show ("team1_winner_text")
                } else if (response === "2") {
                    show ("team2_winner_text")
                } else if (response === "0") {
                    show ("tie_text")
                }
            }
        })
        .fail(function(error) {
            console.error (error);
        })
        .always(function () {
            e.currentTarget.textContent = initialText;
        })
    });

    function show (elem) {
        $("#" + elem).show();
    }

    function hide (elem) {
        $("#" + elem).hide();
    }

    var allOptions = {};

    setDependency("country1", "league1");
    setDependency("country2", "league2");
    setDependency("league1", "team1");
    setDependency("league2", "team2");

    selectFirst("country1");
    selectFirst("country2");

    function setDependency(attr1, attr2) {

        //Get all options
        allOptions[attr2] = $("#" + attr2 + " option");

        //Listner when an option is selected
        $("#" + attr1).change(function () {

            //Clear the next select
            $("#" + attr2 + " option").remove()

            //Get the value of the selected option
            var classN = $("#" + attr1 + " option:selected").val();

            //Filter the next select's options
            var opts = allOptions[attr2].filter("." + classN);

            //Add filered options into the next select
            $.each(opts, function (i, j) {
                $(j).appendTo("#" + attr2);
            });

            if (opts) {
                selectFirst(attr2);
            }
        });
    }

    function selectFirst(elem) {

        let allOptions = $("#" + elem + " option");

        $("#" + elem).val(allOptions[0].value);

        $("#" + elem).change();
    }

</script>

</html>