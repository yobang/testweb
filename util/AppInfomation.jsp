<%@ page contentType="text/html;charset=euc-kr" language="java" %>

<%@ page import="java.lang.System" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>


<pre>
getCanonicalHostName = <%= java.net.InetAddress.getLocalHost().getCanonicalHostName  () %>    
appid = <%= (String)session.getAttribute("appid") %>



=============== User Info ===============
RemoteAddr = <%= request.getRemoteAddr() %>

WL-Proxy-Client-IP = <%= request.getHeader("WL-Proxy-Client-IP") %>
Proxy-Client-IP = <%= request.getHeader("Proxy-Client-IP") %>
Client-IP = <%= request.getHeader("Client-IP") %>
X-Forwarded-For = <%= request.getHeader("X-Forwarded-For") %>

RemoteHost = <%= request.getRemoteHost() %>
ContextPath = <%= request.getContextPath() %>
PathInfo = <%= request.getPathInfo() %>
RemoteUser = <%= request.getRemoteUser() %>
RequestURI = <%= request.getRequestURI() %>
ServerName = <%= request.getServerName() %>
getServerPort = <%= request.getServerPort() %>
ServletPath = <%= request.getServletPath() %>
RequestURL = <%= request.getRequestURL().toString() %>    


=============== Session Info ===============
<%
 String sname ="";
 Object svalue ="";
 Enumeration en = session.getAttributeNames();
 while(en.hasMoreElements()){
   sname = (String)en.nextElement();
   svalue = session.getAttribute(sname);
%>
session attribute name : <%= sname %> => <%= svalue %>
<% 
 }

//session.setMaxInactiveInterval(60*60*8);
%>
session Timeout : <%= session.getMaxInactiveInterval() %>

=============== Cookie Info ===============
<%
 Cookie[] cookies = request.getCookies();
 Cookie thisCookie;
 boolean cookieFound = false;
%>
cookies size[<%=cookies.length %>]
<%
for(int i=0; i < cookies.length; i++) {
thisCookie = cookies[i];
%>
thisCookieName[<%= i%>] =<%=thisCookie.getName()%>  
thisCookie[<%= i%>] =<%=thisCookie%>  
thisCookieValue[<%= i%>] =<%=thisCookie.getValue()%>  
thisCookieMaxAge[<%= i%>] =<%=thisCookie.getMaxAge()%>
<%
}
%>
=============== Server Info ===============
<%
    Properties prop = System.getProperties(); 
    Enumeration enu = prop.keys(); 
    while (enu.hasMoreElements()) { 
        String key = (String) enu.nextElement(); 
        String value = (String) prop.get(key); 
%>
        *: <%= key %> => <%= value %><%
    }
%>    


</pre>