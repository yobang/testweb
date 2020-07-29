<%@	page contentType="text/html;charset=euc-kr" language="java" %>

<%@ page import="java.lang.System" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>

<!doctype html public "-//w3c/dtd HTML 4.0//en">
<!--<META HTTP-EQUIV="Refresh" CONTENT="60;URL=/FailoverTest.jsp"> -->
<html>
<!-- Copyright (c) 1999-2001 by BEA Systems, Inc. All Rights Reserved.-->
<head>
<%
Properties prop = System.getProperties(); 
String InstanceName = (String) prop.get("weblogic.Name"); 
%>
<title>Failover Test[<%=InstanceName%>]</title>
</head>
<body bgcolor="#FFFFFF">
<font face="Helvetica">
<h2>
<font color=#DB1260>
Failover Test [<%=InstanceName%>]
</font>
</h2>
<p>
This JSP shows simple principles of session management
by incrementing a counter each time a user accesses a page.
<p>
<%!
  private int totalHits = 0;
%>
<%


  session = request.getSession(true);
  String ssid = session.getId();
 
  Integer ival = (Integer)session.getAttribute("simplesession.counter");
  if (ival == null) 
    ival = new Integer(1);
  else 
    ival = new Integer(ival.intValue() + 1);
  session.setAttribute("simplesession.counter", ival);
  System.out.println("[SessionTest] count = " + ival );
%>
<%
  Integer cnt = (Integer)application.getAttribute("simplesession.hitcount");
  if (cnt == null)
    cnt = new Integer(1);
  else
    cnt = new Integer(cnt.intValue() + 1);
  application.setAttribute("simplesession.hitcount", cnt);
  //System.out.println("[SessionTest] count = " + ival );
%>
<font color=blue><b>Session ID: <%=ssid %></b></font><br>
<table border=1 cellpadding=6><tr><td width=50% valign=top>
<font face="Helvetica">
<h3>
You have hit this page <font color=red> <%= ival %></font> time<%= (ival.intValue() == 1) ? "" : "s" %>, <br>before the session times out.
</h3>
The value in <font color=red><b>red</b></font> is stored in the HTTP session (<font face="Courier New" size=-1>javax.servlet.http.HttpSession</font>), in an object named <font face="Courier New" size=-1>simplesession.counter</font>. This object has <i>session</i> scope and its integer value is re-set to <font color=red><b>1</b></font> when you reload the page after the session has timed out.
<p>
You can change the time interval after which a session times out. For more information, see the <a href= http://e-docs.bea.com/wls/docs61/webapp/sessions.html#session-timeout>Session Timeout</a> section under <a href= @DOCSWEBROOT/webapp/sessions.html>Using Sessions And Session Persistence in Web Applications</a>.
</font></td>

<td width=50% valign=top><font face="Helvetica">
<h3>You have hit this page a total of <font color=green> <%= cnt %></font> time<%= (cnt.intValue() == 1) ? "" : "s" %>!
</h3>	

The value in <font color=green><b>green</b></font> is stored in the
Servlet Context (<font face="Courier New" size=-1>javax.servlet.ServletContext)</font>, in an object named <font face="Courier New" size=-1>simplesession.hitcount</font>. This object
has <i>application</i> scope and its integer value is incremented each time you
reload the page.

</font>
</td>
</tr></table>

<p>
<font size=-1>Copyright (c) 1999-2000 by BEA Systems, Inc. All Rights Reserved.
</font>

<%
   Cookie[] cookies = request.getCookies();
   
   if(cookies != null){
   System.out.println("cookies.length:"+cookies.length);
   for(int i = 0;i<cookies.length;++i){
   System.out.println("cookies["+i+"].getName():"+cookies[i].getName());

%>
  <br><b>CookieName</b>[<%=cookies[i].getName() %>]  <b>CookieValue</b>[<%=cookies[i].getValue() %>]
  
<%}}

%>




</body>
</html>
