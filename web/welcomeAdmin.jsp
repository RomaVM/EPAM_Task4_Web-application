<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title></title>
</head>
<body>
 <h1>Здравстуйсте Адмимнистратор: ${client.getFirstName()} ${client.getLastName()}</h1>
 <a href="registration.jsp">Зарегистрировать клиента банка</a><br>
 <a href="creationCard.jsp">Создать новый счет для клиента</a><br>
</body>
</html>