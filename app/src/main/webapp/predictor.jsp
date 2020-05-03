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
    </style>

</head>

<body>

    <div class="container">
        <form action="predict" method="post">

            <div class="row">
                <div class="col-md-10">
                    <h1 class="text-center">EU Soccer Match Predictor</h1>
                </div>
                <div class="col-md-2">
                    <a href="/app/">Go to Explorer View</a>
                </div>
            </div>
            <div class="row">
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
                                            <option class=="${team.parent}" value="${team.id}">
                                                <c:out value="${team.name}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <c:if test="${not empty result && result == '1')}">
                                <div class="form-row">
                                    <div class="col-md-12">
                                        <h2>WINNER</h2>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div class="col-md-2 p-5">
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
                                            <option class=="${team.parent}" value="${team.id}">
                                                <c:out value="${team.name}" />
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <c:if test="${result eq '2'}">
                                    <div class="form-row">
                                        <div class="col-md-12">
                                            <h2>WINNER</h2>
                                        </div>
                                    </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mx-auto" style="width: 200px;">
                <button id="predict-btn" type="submit" name="predict-btn" class="btn btn-primary">Predict</button>
            </div>
            
            <c:if test="${result eq '0'}">
                <div class="form-row">
                    <div class="col-md-12">
                        <h2>It's a draw</h2>
                    </div>
                </div>
            </c:if>
        </form>
    </div>

</body>

<script type="text/javascript">
    function predict() {

    }
</script>

</html>