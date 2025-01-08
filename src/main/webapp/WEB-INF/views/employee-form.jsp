<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en" xml:lang="en">
<head>
    <title>Employee Form</title>
</head>
<body>
<h1>Employee Form</h1>
<form action="${employee.id == null ? '/employees' : '/employees/update/' + employee.id}" method="post">
    <input type="hidden" name="id" value="${employee.id}"/>
    <div>
        <label>Name:</label>
        <input type="text" name="name" value="${employee.name}" required/>
    </div>
    <div>
        <label>Department:</label>
        <input type="text" name="department" value="${employee.department}" required/>
    </div>
    <div>
        <label>Salary:</label>
        <input type="number" name="salary" value="${employee.salary}" required/>
    </div>
    <div>
        <button type="submit">Save</button>
    </div>
</form>
<a href="/employees">Back to Employee List</a>
</body>
</html>
