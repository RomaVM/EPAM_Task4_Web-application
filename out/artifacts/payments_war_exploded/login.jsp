<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login page</title>
</head>
<body>
    <form action="handler" method="post">
        Номер телефона с кодом страны(380-50-264-46-34):<br>
        <input type="text" name="phone"  \><!--pattern="\+[0-9]{12}" value="+380"-->
        <br>
        Пароль:<br>
        <input type="password" name="pass" value="">
        <br>
        <input type="submit" name="ok" value="sign in">
    </form>
</body>
</html>