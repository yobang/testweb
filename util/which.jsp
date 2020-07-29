<%--
 Author : Sayjava ( Blog - http://sayjava.egloos.com )
 $Revision : 0.1$
--%>
<%@ page import="java.net.*, java.lang.reflect.*,java.util.*" contentType="text/html; charset=euc-kr"%>
<html>
<head>
<title>Which - File finder in the classpath</title>
<script language="javascript">
	function which(classname) {
		document.whichform.rsc.value = classname.replace(/\./g, "/")+".class";
		document.whichform.submit();
	}
	
	function toggleDetail() {
		button = document.getElementById("detailbutton");
		if(button.value == "+") {
			button.value = "-";
			document.getElementById("classdetail").style.display="block";
		} else {
			button.value = "+";
			document.getElementById("classdetail").style.display="none";
		}
	}
</script>
</head>
<body>
<%
       String rsc = request.getParameter("rsc");
       if(rsc != null && rsc.length() > 0) {
               URL     url     = null;

               ClassLoader loader = Thread.currentThread().getContextClassLoader();
               try {
                       url = loader.getResource(rsc);
                       out.print("<h3>Location</h3>");
                       out.println(url.toString());
                       out.print("<h3>ClassLoader hierarchy</h3>");
                       out.println("<ol>");
                       while(loader != null) {
                               out.println("<li>"+loader.getClass().getName());
                               loader = loader.getParent();
                       }
                       out.println("</ol>");
                       if(rsc.endsWith(".class")) {
                               Class cls = Class.forName(rsc.substring(0, rsc.length()-6).replace('/','.'));
                               loader = cls.getClassLoader();
                               if(loader != null) {
                                   out.println("Used ClassLoader : "+loader.getClass().getName());
                               } else {
                                   out.println("Used ClassLoader not founded.");
                               }
                               out.println(analyzeClass(cls));
                       }
               } catch(Exception e) {
                       out.println("Exception : "+e);
                       e.printStackTrace();
               }
       } else {
               rsc = "";
       }
%>
<br>
<h3>resource name</h3>
<form name="whichform" action="which.jsp">
<input name="rsc" size="100" value="<%=rsc%>">
<input type="submit">
</form>
<br><br><br><hr>
<h3>Usage</h3>
<ul>
       <li> Java class example : java/lang/Object.class
       <li> Properties example : com/sds/rsc/MyResource_ko.properties
</ul>
<h3>System classpath</h3>
<ol>
<%
       String cpath = System.getProperty("java.class.path");
       java.util.StringTokenizer tokens = new java.util.StringTokenizer(cpath, java.io.File.pathSeparator);
       String path = null;
       while(tokens.hasMoreTokens()) {
               path = tokens.nextToken();
               out.println("<li>"+path);
       }
%>
</ol>
</body>
</html>
<%!
	private String analyzeClass(Class cls) {
		if (cls == null) {
			return "cls is null.";
		}
		
		StringBuffer sb = new StringBuffer();
		render(cls, sb);
//		Class[] classes = cls.getClasses();

		return sb.toString();
	}

	private void render(Class cls, StringBuffer sb) {
		sb.append("<h4>\n");
		sb.append(Modifier.toString(cls.getModifiers()));
		sb.append(" ");
		sb.append(cls.getName());
		sb.append(" <input type='button' value='+' onClick='javascript:toggleDetail(this);' id='detailbutton'>");
		sb.append("</h4>\n");
		
		sb.append("<ul id='classdetail' style='display:none'>\n");
		
		Class[] superClass = {cls.getSuperclass()};
		sb.append("<li>Super class</li>\n");
		renderInterfaces(sb, superClass);
		
		Class[] interfaces = cls.getInterfaces();
		sb.append("<li>Interfaces</li>\n");
		renderInterfaces(sb, interfaces);
		
		Constructor[] constructors = cls.getConstructors();
		Constructor[] dconstructors = cls.getDeclaredConstructors();
		sb.append("<li>Constructors</li>\n");
		renderMembers(sb, constructors, dconstructors);
		
		Field[] fields = cls.getFields();
		Field[] dfields = cls.getDeclaredFields();
		sb.append("<li>Fields</li>\n");
		renderMembers(sb, fields, dfields);

		Method[] methods = cls.getMethods();
		Method[] dmethods = cls.getDeclaredMethods();
		sb.append("<li>Methods</li>\n");
		renderMembers(sb, methods, dmethods);
		
		Class[] classes = cls.getClasses();
		Class[] dclasses = cls.getDeclaredClasses();
		sb.append("<li>Classes</li>\n");
		renderMembers(sb, classes, dclasses);
		
		sb.append("</ul>\n");
	}

	private void renderInterfaces(StringBuffer sb, Class[] interfaces) {
		if(interfaces != null) {
			sb.append("<ul>\n");
			for (int i = 0; i < interfaces.length; i++) {
				renderClassWithLink(interfaces[i], sb);
			}
			sb.append("</ul>\n");
		}
		
	}

	private void renderClassWithLink(Class cls, StringBuffer sb) {
		if(cls != null) {
			sb.append("<li>\n");
			sb.append("<a href=\"javascript:which('");
			sb.append(cls.getName());
			sb.append("');\">");
			sb.append(cls.getName());
			sb.append("</a>");
			sb.append("</li>\n");
		}
	}

	private void renderMembers(StringBuffer sb, Object[] objects, Object[] dobjects) {
		if(objects != null) {
			sb.append("<ul>\n");
			for (int i = 0; i < objects.length; i++) {
				render(objects[i], sb, existsInArray(dobjects, objects[i]));
			}
			sb.append("</ul>\n");
		}
	}
	

	
	private void render(Object obj, StringBuffer sb, boolean isDeclared) {
		sb.append("<li>\n");
		if(!isDeclared) sb.append("<i>");
		sb.append(obj.toString());
		if(!isDeclared) sb.append("</i>");
		sb.append("\n");
	}
	
	private boolean existsInArray(Object[] array, Object obj) {
		if(array != null && obj != null) {
			for(int i=0; i< array.length; i++) {
				if(obj.equals(array[i])) {
					return true;
				}
			}
		}
		return false;
	}
	

	%>
<%--
 $Log$
--%>