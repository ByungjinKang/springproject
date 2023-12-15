<%--
  Created by IntelliJ IDEA.
  User: Nick
  Date: 2023-12-05
  Time: 오전 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<form action="/sample/exUploadPost" method="post" enctype="multipart/form-data">

  <div>
    <input type="file" name="files">
  </div>
  <div>
    <input type="file" name="files">
  </div>
  <div>
    <input type="file" name="files">
  </div>
  <div>
    <input type="file" name="files">
  </div>
  <div>
    <input type="file" name="files">
  </div>
  <div>
    <input type="submit">
  </div>

</form>

</body>
</html>
