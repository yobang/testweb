<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="javax.net.ssl.HttpsURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.MalformedURLException" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.PrintWriter" %>
<%
    String contextPath =request.getContextPath();

System.out.println( "1:"+request.getRemoteAddr() );
System.out.println( "2:"+request.getRemoteHost() );
System.out.println( "3:"+request.getContextPath() );
System.out.println( "4:"+request.getPathInfo() );
System.out.println( "5:"+request.getRemoteUser() );
System.out.println( "6:"+request.getRequestURI() );
System.out.println( "7:"+request.getServerName() );
System.out.println( "8:"+request.getServerPort() );
System.out.println( "9:"+request.getServletPath() );
System.out.println( "10:"+request.getRequestURL().toString()); 

%>
<HTML>
<HEAD><title>aweb</title>
</HEAD>
RemoteAddr111 = <%= request.getRemoteAddr() %>
RemoteHost = <%= request.getRemoteHost() %>
ContextPath = <%= request.getContextPath() %>
PathInfo = <%= request.getPathInfo() %>
RemoteUser = <%= request.getRemoteUser() %>
RequestURI = <%= request.getRequestURI() %>
ServerName = <%= request.getServerName() %>
getServerPort = <%= request.getServerPort() %>
ServletPath = <%= request.getServletPath() %>
RequestURL = <%= request.getRequestURL().toString() %>    

<%

   URL  url = new URL("http://192.168.10.6:83/bweb/test.jsp");
   HttpURLConnection connection  = (HttpURLConnection) url.openConnection();

  connection.setDoOutput(true);
  connection.setRequestMethod("GET");

 
  PrintWriter pw = new PrintWriter(connection.getOutputStream());

  pw.write("url="+url);
  pw.write("");

  pw.flush();
  pw.close();

   int code = connection.getResponseCode();

   StringBuffer sb=new StringBuffer();

  BufferedReader in = new BufferedReader(
  new InputStreamReader(
    connection.getInputStream()));

   String inputLine;
   while ((inputLine = in.readLine()) != null) {
  sb.append(inputLine);
  sb.append("$");
   }
   in.close(); 

   System.out.println("결과.....");
   System.out.println(sb.toString());
   out.println(sb.toString());




%>
 
