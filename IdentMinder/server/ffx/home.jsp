<%@ page import="com.netegrity.webapp.page.TaskController,
                 com.netegrity.ims.task.TaskErrorCollection,
                 com.netegrity.ims.task.TaskErrorObject,
                 com.netegrity.ims.tabhandlers.ErrorLevel,
                 java.util.Vector,
                 java.util.Iterator,
                 com.netegrity.webapp.UIContext,
                 com.netegrity.webapp.util.HtmlUtil" %>

<%@ taglib uri="http://www.netegrity.com/taglib/skin" prefix="skin" %>
<%@ taglib uri="http://www.netegrity.com/taglib/imhtml" prefix="imh" %>

<table cellpadding="0" cellspacing="0" style="width: 100%;"><tr><td>

<skin:ifconfirmationpage>
		<div class="im-page-section-header"><a name="startcontent" id="startcontent"><skin:tasktitle /></a></div>
		<table cellpadding="0" cellspacing="10" style="width: 100%;"><tr><td>

	    <skin:lasttasktag var="lastTaskTag" />
	
		<skin:taskstatus />
	
	    <skin:ifreturntosearch>
	        <skin:actionbutton styleClass="im-button" action="action.returntosearch" labelKey="console.button.returnToSearch" />&nbsp;
	    </skin:ifreturntosearch>
	    <skin:actionbutton styleClass="im-button" action="action.ackmsg" labelKey="console.button.ok" />
	
	    <p>&nbsp;</p>
		
		</td></tr></table>
</skin:ifconfirmationpage>


<skin:iferrorpage>
		<div class="im-page-section-header"><a name="startcontent" id="startcontent"><skin:tasktitle /></a></div>
		<table cellpadding="0" cellspacing="10" style="width: 100%;"><tr><td>
	
		<skin:taskstatus />

	    <skin:ifreturntosearch>
	        <skin:actionbutton styleClass="im-button" action="action.returntosearch" labelKey="console.button.returnToSearch" />&nbsp;
	    </skin:ifreturntosearch>
	    <skin:actionbutton styleClass="im-button" action="action.ackmsg" labelKey="console.button.ok" />
	
	    <p>&nbsp;</p>
		</td></tr></table>
</skin:iferrorpage>



<skin:ifprotected>

	<skin:ifhomepage>
	
		<skin:ifcompletedtasks>
			<div class="im-page-section-header"><skin:message key="console.completedTasks" /></div>
			<table cellpadding="0" cellspacing="10" style="width: 100%;"><tr><td>

			<skin:completedtasks/>
			
			</td></tr></table>
		</skin:ifcompletedtasks>
	
		<skin:ifworkitems min="1">
			<div class="im-page-section-header"><skin:message key="console.workList" /></div>
			<table cellpadding="0" cellspacing="10" style="width: 100%;"><tr><td>

			<skin:worklist/>
			
			</td></tr></table>
		</skin:ifworkitems> 
		
		<skin:ifdelegations>
			<div class="im-page-section-header"><skin:message key="console.currentDelegations" /></div>
			<table cellpadding="0" cellspacing="10" style="width: 100%;"><tr><td>

			<skin:currentdelegations/>

			</td></tr></table>
		</skin:ifdelegations>

<%
	boolean homePagePlugins = false;
%>
		<skin:ifhomepageplugins>
			<skin:homepageplugins />
<%
	homePagePlugins = true;
%>
		</skin:ifhomepageplugins>
		 
		<skin:ifworkitems min="0" max="0">
<% if (!homePagePlugins) { %>
		<skin:themetitle var="title" />
			<div class="im-page-section-header"><a name="startcontent" id="startcontent"><%= title %></a></div>
			<table cellpadding="0" cellspacing="10" style="width: 100%;"><tr><td>

			<h1>
			<skin:message key="console.welcome">
				<skin:param name="0" value="<%= title %>" />
			</skin:message>
			</h1>
			<p style="padding: 5px">
				<skin:message key="console.homePage" />
			</p>

			</td></tr></table>
<% } %>
		</skin:ifworkitems>

    </skin:ifhomepage>

</skin:ifprotected>

</td></tr></table>
