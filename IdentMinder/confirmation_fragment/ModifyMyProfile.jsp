
<%@ page import="com.netegrity.llsdk6.imsapi.ImsEnvironment" %>
<%@ page import="com.netegrity.webapp.UIContext" %>
<%@ page import="com.netegrity.ims.util.Localizer" %>

<%
ImsEnvironment env=UIContext.getImsEnvironment(request);
String protectedUrl=env.getBaseURL().toString()+"/"+env.getAlias();
Localizer localizer = Localizer.getInstance("com.netegrity.webapp.selfreg.messages");
%>

<br>
<br>
<table class="fw-messages" width="100%">
 <tr><td colspan="3" class="im-summary">
 Your Profile was changed successfully.</td></tr>
 <tr><td></td></tr>
 <tr><td></td> <tr>
 <tr><td> </td></tr>
</table>
