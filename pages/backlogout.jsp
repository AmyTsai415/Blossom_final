<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%
    // 銷毀會話並重定向到登錄頁面
    session.invalidate();
    response.sendRedirect("index.jsp");
%>