<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %><?xml version="1.0" encoding="iso-8859-1"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://www.netegrity.com/taglib/skin" prefix="skin" %>
<%@ page import="com.netegrity.llsdk6.imsapi.ImsEnvironment" %>
<%@ page import="com.netegrity.webapp.UIContext" %>
<%@ page import="com.netegrity.ims.util.Localizer" %>

<HTML>
<HEAD>
<% response.setHeader("Refresh", "5;url=/myfairfax/logoutconfirm.aspx"); %>
</HEAD>
<BODY>
<%
ImsEnvironment env=UIContext.getImsEnvironment(request);
String protectedUrl="/myfairfax/logoutconfirm.aspx";
Localizer localizer = Localizer.getInstance("com.netegrity.webapp.selfreg.messages");
%>
<BR>
Message to be editied for correction by OTA group for verbage.
<BR>
<BR>
<table class="fw-messages" width="100%">
 <tr><td colspan="3" class="im-summary"><%=localizer.getLocalizedString("selfconfirm.SuccessMessage")%><a href="<%=protectedUrl%>">FairFax County Ident System</a></td></tr>
</table>
</BODY>
</HTML>

