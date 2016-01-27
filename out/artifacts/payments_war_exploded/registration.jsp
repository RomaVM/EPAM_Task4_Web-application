<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Регистрация нового клиента</title>
</head>
<body>
    <form action="handler" method="post">

        Номер телефона:<br>
        <input type="text" name="phone_number" value=""><br>
        Имя клиента:<br>
        <input type="text" name="first_name" value=""><br>
        Фамилия клиента:<br>
        <input type="text" name="last_name" value=""><br>
        Пароль(20 знаков макс):<br>
        <input type="password" name="pass" value=""><br>
        <input type="submit" name="ok" value="sign up">

    </form>
    ${error_message}

</body>
</html>