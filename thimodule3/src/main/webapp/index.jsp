<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Product Management</title>
</head>
<body>
<h1>Product List</h1>
<a href="product?action=showAddForm">Add New Product</a>
<table border="1">
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Price</th>
    <th>Quantity</th>
    <th>Color</th>
    <th>Description</th>
    <th>Category</th>
    <th>Actions</th>
  </tr>
  <c:forEach var="product" items="${productList}">
    <tr>
      <td>${product.id}</td>
      <td>${product.name}</td>
      <td>${product.price}</td>
      <td>${product.quantity}</td>
      <td>${product.color}</td>
      <td>${product.description}</td>
      <td>${product.category}</td>
      <td>
        <a href="product?action=delete&id=${product.id}">Delete</a>
      </td>
    </tr>
  </c:forEach>
</table>
</body>
</html>
