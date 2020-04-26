<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- @author Tung -->
<!-- TODO : This page should contain the code to display Match Data Explorer UI -->

<!-- see index_page_mock_ui.html (in the same folder as this page) for what to include in the page; the data presented in the UI are all mock data; assume they are provided by the server -->

<html>

<head>
    <title>European Soccer Data Explorer</title>

    <style>
    </style>

</head>

<body>

      <form  method = "POST">
         Username: <input type = "text" name = "username">
         <br />
         Password: <input type="password"  name = "pass" />
         <input type = "submit" value = "Submit" />
      </form>
      
    <a href="#">Match Predictor</a>

    <div>
        <button id="search-btn" type="submit" name="search-btn" class="btn btn-primary"
            disabled>Search</button>
    </div>

</body>

<script type="text/javascript">

</script>

</html>