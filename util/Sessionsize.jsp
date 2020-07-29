<%@ page  info="Gets the weight of current HttpSession"  contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.ObjectOutputStream, java.io.ByteArrayOutputStream,
                 java.io.IOException, java.util.Enumeration"%>
<html>
  <head> 
    <title>Session check page</title>
  </head>
<body>
<h3>Show session elements</h3>
<%
	try
	{
		%>
		<center>
		<table border=0 cellspacing=3 width="100%" style="font-size:10pt;">
		<tr valign="top" bgcolor="#eeeefd">
			<td align="left" width="20%"><b>Name </b>(Size)</td>
			<td align="left" width="80%"><b>Class</b> / Value</td>
		</tr>

		<%	
		Enumeration sessionNames = session.getAttributeNames();
		String	name;
		Object	elt = new Object();
		int size = 0;
		
		while (sessionNames.hasMoreElements()) 
		{
		    name = (String)sessionNames.nextElement();    
			elt	= session.getAttribute(name);
			%>
		
			<tr valign="top">

				<td align="left" width="20%" nowrap="false">
					<%
					ByteArrayOutputStream myBAOS = null;
					ObjectOutputStream myOOS = null;
					try 
					{
						myBAOS	= new ByteArrayOutputStream ();
						myOOS	= new ObjectOutputStream( myBAOS );
						myOOS.writeObject( elt );
						out.println("<div style=\"background-color:#f6f6fe;\"><b>"+ name +"</b></div>("+ myBAOS.size() +")");
						size += myBAOS.size();
					} 
					catch (Exception IOE) 	{
						out.println("<div style=\"background-color:#fff0f0;\"><b>"+ name +"</b></div>not serializable");
					} finally {
                        myOOS.close();
                        myBAOS.close();
                    }
					%>
				</td>
	
				<td  align="left" width="80%">
					<div style="background-color:#f8f8fe;"><b><%=elt.getClass()%></b></div>
					<%=elt.toString()%>
				</td>
			
			</tr>
		<%
		} // end of while loop for session names
		%>
		<tr >
			<td align="left" bgcolor="#eeeefd">Total size of the serializable attributes <b><%=size%></b> bytes</td>
			<td>&nbsp;</td>
		</tr>
	
		</table></center>
	<%
	}
	catch (IOException ex)
	{
		out.println("IOException parsing session ["+ ex.getMessage() +"]");
	}	
%>
</body>
</html>