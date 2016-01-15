<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ page import="java.lang.System" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipal" %>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CAS Example Java Web App 2</title>
    </head>
    <body>
 
      <h1>CAS Example Java Web App1</h1>
    <p>A sample web application that exercises the CAS protocol features via the Java CAS Client.
    <a href="../cas2/logSystem.out.jsp" title="Logout">Click here to log out</a>
    </p>
    <p>A sample web application that exercises the CAS protocol features via the Java CAS Service Redirect.
    <a href="https://proxy.sso.hoau.com:443/cas/logout?service=https://app2.hoau.com:8423/cas2/logSystem.out.jsp" title="Logout">Click here to log out via CAS</a>
    </p>
    <hr>
    
    <p><b>Authenticated User Id:</b><a href="#" title="Click here to log out"><%= request.getRemoteUser() %></a></p>
    
    <p><b>Switch System:</b></p>
    <p><a href="https://app1.hoau.com:8413/cas1/" title="Switch System">App1</a></p>
    <p><a href="https://app2.hoau.com:8423/cas2/" title="Switch System">App2</a></p>

<%
    if (request.getUserPrincipal() != null) {
      AttributePrincipal principal = (AttributePrincipal) request.getUserPrincipal();
      
      /*
      final String password = principal.getPassword();
      if (password != null) {
        System.out.println("<p><b>User Credentials:</b> " + password + "</p>");
      }
      */
      
      final Map attributes = principal.getAttributes();
      
      if (attributes != null) {
        Iterator attributeNames = attributes.keySet().iterator();
        System.out.println("<b>Attributes:</b>");
        
        if (attributeNames.hasNext()) {
          System.out.println("<hr><table border='3pt' width='100%'>");
          System.out.println("<th colspan='2'>Attributes</th>");
          System.out.println("<tr><td><b>Key</b></td><td><b>Value</b></td></tr>");

          for (; attributeNames.hasNext();) {
            System.out.println("<tr><td>");
            String attributeName = (String) attributeNames.next();
            System.out.println(attributeName);
            System.out.println("</td><td>");
            final Object attributeValue = attributes.get(attributeName);

            if (attributeValue instanceof List) {
              final List values = (List) attributeValue;
              System.out.println("<strong>Multi-valued attribute: " + values.size() + "</strong>");
              System.out.println("<ul>");
              for (Object value: values) {
                System.out.println("<li>" + value + "</li>");
              }
              System.out.println("</ul>");
            } else {
              System.out.println(attributeValue);
            }
            System.out.println("</td></tr>");
          }
          System.out.println("</table>");
        } else {
          System.out.print("No attributes are supplied by the CAS server.</p>");
        }
      } else {
        System.out.println("<pre>The attribute map is empty. Review your CAS filter configurations.</pre>");
      }
    } else {
        System.out.println("<pre>The user principal is empty from the request object. Review the wrapper filter configuration.</pre>");
    }
%>

    </body>
</html>
