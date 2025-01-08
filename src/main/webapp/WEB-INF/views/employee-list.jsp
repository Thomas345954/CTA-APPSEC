<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en" xml:lang="en">
<head>
    <title>Employee List</title>
</head>
<body>
<h1>Employee List</h1>
<a href="/employees/new">Add New Employee</a>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Department</th>
        <th>Salary</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="employee" items="${employees}">
        <tr>
            <td>${employee.id}</td>
            <td>${employee.name}</td>
            <td>${employee.department}</td>
            <td>${employee.salary}</td>
            <td>
                <a href="/employees/edit/${employee.id}">Edit</a>
                <a href="/employees/delete/${employee.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>