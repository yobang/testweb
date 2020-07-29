<%
	/*
		(#) WhichClass.jsp
		@date : 2004-09-15
		@author : 박중현, 손경준(edit)
		# ClassLoader의 종류와 Load해 오는 위치
		1. SystemClassLoader
		loader : java.lang.SystemClassLoaderAction
		위치 : ~/jre/lib/rt.jar

		2. ExtClassLoader
		loader : sun.misc.Launcher$ExtClassLoader
		위치 : ~/jre/lib/ext/*.jar

		3. AppClassLoader
		loader : sun.misc.Launcher$AppClassLoader
		위치 : classpath에 설정해 놓은 위치
	*/
%>

<%@ page import="java.util.*"%>

<FONT FACE=VERDANA SIZE=2> 
<%
    String reqName = null;
    java.net.URL classUrl = null;
 
    reqName = request.getParameter("reqName");
    if (reqName == null || reqName.trim().length() == 0) {
        reqName = "";
    }
%>
 
<html>
<body onLoad="document.form1.reqButton.focus();">
 
<FONT COLOR=BLUE SIZE=4 FACE="Georgia"><B><I>FINDER : find class location & ClassLoader </I></B></FONT><HR COLOR=BLACK>
[Search] (ex) java.lang.String
<form action="finder.jsp" name=form1 METHOD=POST>
<input type=text name="reqName" value="<%= reqName %>">
<input type=submit name=reqButton value="Search">
</form>
<HR COLOR=BLACK> 
<%
    if (reqName.trim().length() != 0) {
%>
 

[Search Result]
<HR COLOR=BLACK>
<%
		String packageName=reqName;
		reqName=reqName.replace('.','/');
		if(reqName.indexOf("class")==-1) reqName=reqName+".class";
		if(!reqName.startsWith("/")) reqName="/"+reqName;
        classUrl = this.getClass().getResource(reqName);

        if (classUrl == null) {
            out.println(reqName + " not found");
        } else {
			StringBuffer bootstrapClassPath = new StringBuffer(System.getProperties().getProperty("sun.boot.class.path"));
			StringBuffer extensionClassPath = new StringBuffer(System.getProperties().getProperty("java.ext.dirs"));
			StringBuffer systemClassPath    = new StringBuffer(System.getProperties().getProperty("java.class.path"));
			out.println("Bootstrap Class Path = " + bootstrapClassPath + "<BR>");
			out.println("Extension Class Path = " + extensionClassPath + "<BR>");
			out.println("System    Class Path = " + systemClassPath + "<BR>");
			out.println("<HR><B><FONT COLOR=RED>package name = " + packageName + "<BR>Location = [ " +  classUrl.getFile() + " ]</B></FONT><HR>");
			out.println("System ClassLoader = " + this.getClass().getClassLoader().getSystemClassLoader() +"<BR>" );
			out.println("App ClassLoader = " + this.getClass().getClassLoader()+ "<HR>");
			Object o=Class.forName(packageName).newInstance();
			out.println("<B><FONT COLOR=BLUE>Class's ClassLoader = " + o.getClass().getClassLoader()  + "<HR>");
			
         }
        out.println("<br>");
 
    }
%>

 
