To override all task confirmation pages, you can place a .jsp file in this directory named default.jsp.

To override the confirmation page for a task, you can place a .jsp file in this directory named <task_tag>.jsp (for example SelfRegistration.jsp)

JSP files in this directory will be displayed outside of the default IdentityMinder console.  They should generate complete HTML pages.  Links back to the console can be dynamically placed in the page by using a request attribute named 'CONSOLE_URL' as follows:

<%
    String consoleURL = (String) request.getAttribute("CONSOLE_URL");
%>
<a href="<%= consoleURL %>">Back to IdentityMinder</a>
