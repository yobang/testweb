<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page language="java" %>
<%@ page import="frame.include.*" %>
<%@ page import="frame.util.*" %>


<%-- Parameter�� �Ѿ�� ������      --%>
<%
    CommonUtil     cmnUtil = new CommonUtil();
    
    String curr_time = cmnUtil.getDateTimeSec();
%>

<HTML>
<HEAD>

</HEAD>
<BODY>
<FORM method="post"  name="test" >
<table cellpadding="1" cellspacing="1" border=0 style="border:solid 1px #E6E6E9" >
<tr><td>���� �ð�</td><td><%=curr_time%></td></tr>
<tr><td>request.getRemoteAddr()</td><td><%=request.getRemoteAddr()%></td></tr>
</table>
</FORM>
</BODY>
</HTML>