<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipal" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CAS Example Java Web App</title>
</head>
<body>

<h1>CAS Example Java Web App1</h1>
<p>A sample web application that exercises the CAS protocol features via the Java CAS Client.
    <a href="../cas1/logout.jsp" title="Logout">Click here to log out</a>
</p>
<p>A sample web application that exercises the CAS protocol features via the Java CAS Service Redirect.
    <a href="https://proxy.sso.hoau.com:443/cas/logout?service=https://app1.hoau.com:8413/cas1/logout.jsp" title="Logout">Click here to log out via CAS</a>
</p>
<hr>

<p><b>Authenticated User Id:</b><a href="#" title="Click here to log out"><%= request.getRemoteUser() %></a></p>


<p><b>Switch System:</b></p>
<p><a href="https://app1.hoau.com:8413/cas1/" title="Switch System">App1</a></p>
<p><a href="https://app2.hoau.com:8423/cas2/" title="Switch System">App2</a></p>
<p>Hello <%=request.getUserPrincipal().getName() %></p>
<p>Hello <%= ((AttributePrincipal)request.getUserPrincipal()).getAttributes().get("name") %> </p>
<%
    Map<?,?> attributes = ((AttributePrincipal)request.getUserPrincipal()).getAttributes();
    if( attributes == null ) {
        out.println("<b>No Attributes</b>");
        throw new ServletException("no attributes set by the CAS client");
    }
    String name = (String) attributes .get("name");
    out.println("<b>Name:</b>" + name);

    if (request.getUserPrincipal() != null) {
        // AttributePrincipal principal = (AttributePrincipal) request.getUserPrincipal();
      
      /*
      final String password = principal.getPassword();
      if (password != null) {
        out.println("<p><b>User Credentials:</b> " + password + "</p>");
      }
      */

        // final Map attributes = principal.getAttributes();

        if (attributes != null) {
            Iterator attributeNames = attributes.keySet().iterator();
            out.println("<b>Attributes:</b>");

            if (attributeNames.hasNext()) {
                out.println("<hr><table border='3pt' width='100%'>");
                out.println("<th colspan='2'>Attributes</th>");
                out.println("<tr><td><b>Key</b></td><td><b>Value</b></td></tr>");

                for (; attributeNames.hasNext();) {
                    out.println("<tr><td>");
                    String attributeName = (String) attributeNames.next();
                    out.println(attributeName);
                    out.println("</td><td>");
                    final Object attributeValue = attributes.get(attributeName);

                    if (attributeValue instanceof List) {
                        final List values = (List) attributeValue;
                        out.println("<strong>Multi-valued attribute: " + values.size() + "</strong>");
                        out.println("<ul>");
                        for (Object value: values) {
                            out.println("<li>" + value + "</li>");
                        }
                        out.println("</ul>");
                    } else {
                        out.println(attributeValue);
                    }
                    out.println("</td></tr>");
                }
                out.println("</table>");
            } else {
                out.print("No attributes are supplied by the CAS server.</p>");
            }
        } else {
            out.println("<pre>The attribute map is empty. Review your CAS filter configurations.</pre>");
        }
    } else {
        out.println("<pre>The user principal is empty from the request object. Review the wrapper filter configuration.</pre>");
    }
%>
</body>
</html>
