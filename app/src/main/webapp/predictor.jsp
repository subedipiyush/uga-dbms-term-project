<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- @author Anthony Holevinski -->
<!-- TODO : This page should contain the code to display Match Prediction UI -->


<!-- see predictor_page_mock_ui.html (in the same folder as this page) for what to include in the page; the data presented in the UI are all mock data; assume they are provided by the server -->

<html>

<head>
    <title>Match Predictor</title>

    <style>
        h1 {
            width: auto;
            text-align: center;
        }

        .filter {
            padding-left: 13%;
            width: 100%;
        }

        .filter td {
            padding: 3%;
            margin-left:20%;
        }

        .display {
            margin-top: 4%;
            /* padding-left: 13%; */
            width: 100%;
            text-align: center;
        }

        .display td {
            font-size: x-large;
            font-weight: bold;
        }
    </style>

</head>

<body>

    <div>
        <table class="filter">
            <tr>
                <td>
                    <label for="country1">Country: </label>
                    <select id="country1" required>
                        <c:forEach var="country" items="${listCountries.rows}">
                            <option value="${country}"><c:out value="${country}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <label for="country2">Country: </label>
                    <select id="country2" required>
                        <c:forEach var="country" items="${listCountries.rows}">
                            <option value="${country}"><c:out value="${country}" /></option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="league1">League: </label>
                    <select id="league1" required disabled>
                        <c:forEach var="league" items="${listLeagues.rows}">
                            <!-- league.get(0) is the name of the league, and league.get(1) is the country of the league -->
                            <option class=="${fn:replace(${league.get(1)}, ' ', '_')}" value="${league.get(0)}"><c:out value="${league.get(0)}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <label for="league2">League: </label>
                    <select id="league2" required disabled>
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
                            <option class=="${fn:replace(${team.get(1)}, ' ', '_')}" value="${team.get(0)}"><c:out value="${team.get(0)}" /></option>
                        </c:forEach>
                    </select>
                </td>
                <td>
                    <label for="team2">Team: </label>
                    <select id="team2" required disabled>
                        <c:forEach var="team" items="${listTeams.rows}">
                            <option class=="${fn:replace(${team.get(1)}, ' ', '_')}" value="${team.get(0)}"><c:out value="${team.get(0)}" /></option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <button id="predict-btn" type="submit" name="predict-btn" class="btn btn-primary"
            onclick"">Predict</button>
    </div>

</body>

<script type="text/javascript">
    function predict() {
        
    }
</script>

</html>