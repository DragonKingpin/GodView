<%--
  Created by IntelliJ IDEA.
  User: undefined
  Date: 2020/11/21
  Time: 23:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div id="magic">
    <p>This is magic</p>
</div>

<div id="ha">
    <p>This is ha</p>
</div>

<div id="fa">
    <p>This is fa</p>
</div>

<form name="myTest" method="post" enctype="multipart/form-data">
    <input name="fileA" type="file">
    <input name="fileB" type="file">
    <input name="nane" type="text">
    <input type="submit">
</form>

<script src="/root/assets/js/pinecone.js"></script>
<script>
    var pageData = ${szPageData};

    $_CPD({
        "magic": function () {
            trace("Jesus!Guess what fuck now. magic.");
            $_PINE( "#magic p" ).text( pageData["debug"] );
        },
        "ha": function () {
            trace("Jesus!Guess what fuck now. ha");
            $_PINE( "#ha p" ).text( pageData["debug"] );
        },
        "fa": function () {
            trace("Jesus!Guess what fuck now. fa");
            $_PINE( "#fa p" ).text( pageData["debug"] );
        }

    }).summon($_GET["action"]);

</script>
</body>
</html>
