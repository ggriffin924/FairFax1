
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
 Your Password was changed successfully. Make sure you remember your password. You can also change your password anytime by accessing profile link from the menu.</td></tr>
 <tr><td>Please click on the link below to return to the portal home page</td></tr>
 <tr><td> </td> <tr>
 <tr><td><FORM METHOD="LINK" ACTION="https://publicacc.fairfaxcounty.gov/myfairfax/">
 <INPUT TYPE="submit" VALUE="Portal Home">
 </FORM> 
 </td></tr>
</table>
