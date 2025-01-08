<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
   <head>
	  <%@ include file="/WEB-INF/views/right-click.jsp" %>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Payment History</title>
      <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	  <!----External styles-->
	  <%@ include file="/WEB-INF/views/css.jsp" %>
      <!-- Fix Internet Explorer ______________________________________-->
      <!--[if lt IE 9]>
      <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
      <script src="vendor/html5shiv.js"></script>
      <script src="vendor/respond.js"></script>
      <![endif]-->
      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
      <style>
         .header-container {
         display: flex;
         justify-content: space-between;
         align-items: center;
         margin-bottom: 10px;
         }
         .header-container h3 {
         margin: 0;
         padding: 0;
         }
         .search-box-container {
         width: 25%;
         display: flex;
         justify-content: flex-end;
         }
         .search-box {
         width: 100%;
         }
         .rows-per-page {
         width: 50%;
         }
         .form-group {
         margin: 0;
         padding: 0;
         }
         .table-responsive {
         margin-top: 10px;
         }
         .footer-container {
         display: flex;
         justify-content: space-between;
         align-items: center;
         margin-top: 10px;
         }
         .receipt-link {
         color: blue;
         text-decoration: underline;
         }
         .receipt-link:hover {
         color: blue;
         text-decoration: underline;
         }
         .table-center-align th,
         .table-center-align td {
         text-align: center;
         }
      </style>
   </head>
   <body>
	
      <div>
         <div class="header-container  head-with-search">
            <aside class="col-md-6 udf-top-left ud-form-top">
               <h3>Payment History</h3>
            </aside>
            <div class="col-md-6 search-box-container">
               <label for="searchBox" class="sr-only">Search</label>
               <input type="text" class="form-control search-box" id="searchBox" placeholder="Search">
            </div>
         </div>



         <div class="table-responsive new-tab-layout">
            <table>
               <thead>
                  <tr>
                     <th>Transaction ID</th>
                     <th>Date</th>
                     <th>No. of Files</th>
                     <th>Total</th>
                     <th>Payment Method</th>
                     <th>Amount Status</th>
                  </tr>
               </thead>
               <tbody id="reportTableBody">
                  <c:forEach var="paymentHistory" items="${paymentHistory}">
                     <tr>
                        <td>${paymentHistory.id}</td>
                        <td><fmt:formatDate value="${paymentHistory.created_date}" pattern="MM/dd/yyyy HH:mm:ss"/></td>
                        <td>${paymentHistory.nofiles}</td>
                        <td>$${paymentHistory.amount}</td>
                        <td>${paymentHistory.payment_method}</td>
                        <td>
                           <!--insert receipt here-->
                           <c:url value="/receipt/${paymentHistory.transaction_id}" var="receiptUrl" />
                           <c:if test="${paymentHistory.amount_status == 'Completed'}">
                              <a href="${receiptUrl}" class="receipt-link" target="_blank">${paymentHistory.amount_status}</a>
                           </c:if>
                           <c:if test="${paymentHistory.amount_status == 'Failed'}">
                              <a>Failed</a>
                           </c:if>
                        </td>
                     </tr>
                  </c:forEach>
               </tbody>
            </table>
         </div>
         <div class="footer-container tab-footer">
            <div class="rows-per-page-container">
               <label for="rowsPerPageSelect">Rows per page:</label>
               <select class="form-control form-field rows-per-page lab-select" id="rowsPerPageSelect">
                  <option value="10">10</option>
                  <option value="20">20</option>
                  <option value="50">50</option>
                  <option value="100">100</option>
                  <option value="1000">1000</option>
               </select>
            </div>
         </div>
         <script>
            $(document).ready(function() {
                var rows = $('#reportTableBody tr');
                var rowsPerPage = parseInt($('#rowsPerPageSelect').val());

                function updateTable() {
                    var searchValue = $('#searchBox').val().toLowerCase();
                    var visibleRows = rows.filter(function() {
                        return $(this).text().toLowerCase().indexOf(searchValue) > -1;
                    });

                    rows.hide();
                    visibleRows.slice(0, rowsPerPage).show();
                }

                $('#rowsPerPageSelect').change(function() {
                    rowsPerPage = parseInt($(this).val());
                    updateTable();
                });

                $('#searchBox').on('keyup', function() {
                    updateTable();
                });

                // Initialize to show rows per page on page load
                updateTable();
            });
         </script>
		 <%@ include file="/WEB-INF/views/js.jsp" %>
   </body>
</html>
