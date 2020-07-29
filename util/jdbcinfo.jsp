<html>
<head>
<title>Infomation of Database & JDBC Driver Version</title>
</head>

<body bgcolor="#FFFFFF">
<font face="Helvetica">

<h2><font color=#DB1260> Infomation of Database & JDBC Driver Version </font></h2>
<%@ page import="javax.sql.*,java.sql.*,javax.naming.*,java.util.*" %>
<%@ page session="false" %>
<font size="-1"><p>
<form method="post" name="jdbcinfo" action="jdbcinfo.jsp">
<table border=0 cellspacing=1 cellpadding=2 width=45%>
   <tr>
      <td width=30%><font face="Helvetica"><b>Data Source Name :</b></td>
<%
      if ( (String)request.getParameter("ds_name")!= null){
%>
      <td><font face="Helvetica"><input type="text" name="ds_name" size=50 value="<%=request.getParameter("ds_name") %>" ></td>
<%
      }else{
%>
      <td><font face="Helvetica"><input type="text" name="ds_name" size=50 value="" ></td>
<%
      }
%>
      <td><font face="Helvetica"><input type="Submit" value="Submit" name="Submit"></td>
   </tr>
</table>
</form>
===================================================================


<%
if ("POST".equals(request.getMethod())) {
  StringBuffer sbError = new StringBuffer();
  DatabaseMetaData dbMetaData = null;
  Connection conn = null;
//  String DS_NAME = null;
  System.out.println(request.getSession(false));
  try {
//    if((String)request.getParameter("ds_name") != null){
       String DS_NAME = (String)request.getParameter("ds_name");
//    }
    
    Context ctx = new InitialContext();
    DataSource ds = (DataSource)ctx.lookup(DS_NAME);
    conn = ds.getConnection();
    dbMetaData = conn.getMetaData();
%>
<p>

<h4>Database Infomation</h4>
<p>
Database URL: <%= dbMetaData.getURL() %><br>
Database User: <%= dbMetaData.getUserName() %><br>
<p>
Database Name: <%= dbMetaData.getDatabaseProductName() %><br>
Version: <%= dbMetaData.getDatabaseProductVersion() %><br>
<p>
<h4>JDBC Driver Infomation</h4>
<p>
Name of JDBC Driver: <%= dbMetaData.getDriverName() %><br>
Version: <%= dbMetaData.getDriverVersion() %><br>


<%
  } catch (NameNotFoundException e) {
    sbError.append(e.toString());
  } catch (ClassCastException e) {
    sbError.append(e.toString() + ": (Solution) Please!! Input DataSource Name");
  } catch (SQLException e) {
    sbError.append(e.toString());
  } finally {
    if (conn != null) {
      try {
        conn.close();
      } catch (SQLException e) {
        sbError.append(e.toString());
      }
    }
  }
  if (sbError.length() != 0) {
%>
<p>
<h4>Error Information</h4>
<p>
<%
   out.println(sbError.toString());

  }else{
%>
<p>No error
<%
  } // if (sbError.length() != 0)
  
} //if ("POST".equals(request.getMethod()))
%>
</font>
</body>
</html>