<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="login" tagdir="/WEB-INF/tags/login" %>

<login:base pageTitle="Login">
    <div style="width: 100%; display: flex; flex-flow: column; align-items: center;">
        <form action="j_security_check" method="post">
            <h2>Login</h2>

            <div>
                <label for="email">Email</label>
                <input type="email" name="j_username" id="email">
            </div>

            <div>
                <label for="password">Password</label>
                <input type="password" name="j_password" id="password">
            </div>

            <div>
                <sub><a href="#">Forgot password?</a></sub>
            </div>

            <c:if test="${param.get('error') != null}">Invalid username or password</c:if>

            <button type="submit">Login</button>
        </form>
    </div>
</login:base>
