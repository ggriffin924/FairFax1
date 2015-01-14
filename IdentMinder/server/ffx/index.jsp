<%@ taglib uri="http://www.netegrity.com/taglib/skin" prefix="skin" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<skin:update>
	<skin:skin name="ffx" filename="/app/ffx/ca/ca.properties" />
</skin:update>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ page import="com.netegrity.ims.util.Localizer" %>
<%@ page import="com.netegrity.webapp.util.TaskCategoryHelper" %>
<%@ page import="com.netegrity.webapp.util.TaskDTO" %>
<%@ page import="com.netegrity.webapp.UIContext" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.util.Vector" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="/500.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml" lang="<%= Localizer.getInstance().getLanguageCode(UIContext.getLocale(request))%>">
<f:view>
<head>
<%
  TaskDTO activeTask = TaskCategoryHelper.getInstance(request).getActiveTask(request);
  boolean suppressTaskNavigation = false;
  if (activeTask != null) {
    suppressTaskNavigation = activeTask.isSuppressTaskNavigation();
  }
%>
<%
List<String> categories = new Vector<String>();
%>
<skin:categories type="all">
	<skin:category var="catname" />
<%
	categories.add(catname);
%>
</skin:categories>
<%
  if(categories.size()==0){
    suppressTaskNavigation=true;
   }
%>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title><skin:themetitle/>
	<skin:iftaskpage>
	: <skin:tasktitle />
	</skin:iftaskpage>
</title>

<skin:imhead />
<!-- ### Ending JavaScripts and CSS Style Reference Section. #####-->
<link type="text/css" rel="stylesheet" href="/resources/public/web/templates/css/styles.css"/>
<link type="text/css" rel="stylesheet" href="/resources/public/web/templates/css/application.css"/>
<!--  Start of Fairfax head code -->
<!-- ### Begining FFX JavaScripts and CSS Style Reference Section #####-->
<%
	InetAddress ia = InetAddress.getLocalHost();
    String hostName=ia.getHostName();
	String hostNumber = hostName.substring(hostName.length() -1);
%>
    	 <script type="text/javascript" src="https://www.fairfaxcounty.gov/resources/public/web/templates/js/common.js"></script>
<!-- End of Fairfax head code -->
<skin:stylesheet media="screen,print" src="skin.css" />

<script type="text/javascript">
<skin:message key="console.timeout.alert.title" var="timeouttitle" />
<skin:message key="console.timeout.alert" var="timeoutmessage" />
<skin:message key="console.hideTasks" var="hideTasks" />
<skin:message key="console.showTasks" var="showTasks" />
<skin:message key="console.toggleMenu" var="toggleMenu" />

var setTimeoutVar = setTimeout("Ext.MessageBox.alert('<%=timeouttitle%>','<%=timeoutmessage%>')",<%=session.getMaxInactiveInterval() * 1000%> - 5*60*1000);

function resizePanel(panel, adjWidth, adjHeight, rawWidth, rawHeight) {
	if (Ext.isIE) {
		// IE workaround for scrollbar issue: with xhtml transitional doctype a vertical
		// scrollbar will force a horizontal scrollbar to appear when it is not neccessary
		var content = document.getElementById('center1');

		var isVerticalScrollbar = adjHeight < content.offsetHeight;
		if (isVerticalScrollbar) {
			content.style.width = (adjWidth - 20) + 'px';
		}
		else {
			content.style.width = '';
		}
	}
}

var categoryArray = new Array();
var catid = 0;
var collapsedstate = false;
var lt = '<'; <%-- this is used to prevent tomahawk's ReducedHtmlParser from trying to parse html within the js --%>

<skin:categories type="all">
	<skin:category var="catname" />
		categoryArray[catid++] = {
			cls:'ca-gray-head',
			contentEl: 'west' + catid,
			stateId: 'west' + catid,
			title: lt + 'a href="#"><skin:category />' + lt + '/a>',
			collapsed: collapsedstate,
			border: true,
			autoHeight:true,
			autoScroll: false
		}
		collapsedstate = true;
</skin:categories>

Ext.state.Manager.setProvider(new Ext.state.CookieProvider({expires: null}));

Ext.onReady(function(){
var isTaskPage = false;
<skin:iftaskpage>
	isTaskPage = true;
</skin:iftaskpage>

<skin:message key="console.tasks" var="taskstitle" />

	var viewport = new Ext.Viewport({
		layout: 'border',
		items: [
		// create instance immediately
		new Ext.BoxComponent({
			region: 'north',
			contentEl: 'north',
			<skin:ifpublic>
			height: 150 // give north and south regions a height
			</skin:ifpublic>
			<skin:ifprotected>
			height: 170
			</skin:ifprotected>
			
		}),
		
<% if (!suppressTaskNavigation) { %>
<skin:ifprotected>
		{
			region: 'west',
			id: 'west-panel', // see Ext.getCmp() below
			title: '<%= taskstitle %>',			
			split: true,
			width: 200,
			minSize: 175,
			maxSize: 400,
			collapsible: isTaskPage,
			margins: '0 0 0 5',
			autoScroll: true,
			layout: {
				type: 'accordion',
				animate: true
			},
	        defaults: {
	            stateEvents: ["collapse", "expand"],
	            getState: function() {
	                return {collapsed: this.collapsed};
	            }
	        },			
			items: categoryArray,
			listeners: {
				collapse: setTitleForPanelToggle,
				expand: setTitleForPanelToggle
			}
		},
</skin:ifprotected>
<% } %>
		{
			region: 'center', // a center region is ALWAYS required for border layout
			contentEl: 'center1',
			autoScroll: true,
			listeners: {
				resize: resizePanel
			}
		},

		{
			// Marpo01: 508 Compliance issues need the south panel init via ext-js to be last to keep the ordering synched with visual order
			// lazily created panel (xtype:'panel' is default)
			region: 'south',
			contentEl: 'south',
			height: 130,
			margins: '0 0 0 0'
		}
]
	});
	
<%	if (!suppressTaskNavigation) { %>
<skin:ifprotected>
		var west= Ext.getCmp('west-panel');
		if (!isTaskPage) {
			west.expand();
		}

		setTitleForPanelToggle(west);
		
		setTitleForCSSClass('x-tool-toggle', '<%= toggleMenu %>');
		
		var cat2 = Ext.state.Manager.get('cat2');
		var cat3 = Ext.state.Manager.get('cat3');

		if (cat2 != null && cat2.length > 0) {
			toggleMenu(cat2);
		}

		if (cat3 != null && cat3.length > 0) {
			toggleMenu(cat3, cat2);
		}
</skin:ifprotected>
<%	} %>

// 'isPanelFocusSet' global variable is used to set the right panel elements focus on page load  
Ext.state.Manager.set('isPanelFocusSet', 'false');

// set the default button focus on 'No' button for MessageBox
//Ext.MessageBox.getDialog().defaultButton = 2;

	var e = document.getElementById("skiplinks");
	if (e != null) {
	    e.style.display='block';
	}
	
	// if error messages present, set the focus on error messages table so that screen reader will read the message on page load
	var errorTable = document.getElementById("errortablelink");
	if (errorTable != null) {
		setTimeout(function() {
			errorTable.focus();
	   }, 600)
	}
	
	// if task confirmation message present, set the focus on task confirmation message table so that screen reader will read the message on page load
	var tconfirmLink = document.getElementById("taskconfirmlink");
	if (tconfirmLink != null) {
		setTimeout(function() {
			tconfirmLink.focus();
	   }, 600)
	}
	
	// if task error message present, set the focus on task error message table so that screen reader will read the message on page load
	var terrorLink = document.getElementById("taskerrorlink");
	if (terrorLink != null) {
		setTimeout(function() {
			terrorLink.focus();
	   }, 600)
	}
	
	// if search results present, set the focus on search results table so that screen reader will start reading from search results on page load
	// when there is error message, etc, don't set focus to search results
	if (errorTable == null && tconfirmLink == null && terrorLink == null){
		var srLink = document.getElementById("searchresultslink");
		if (srLink != null) {
			setTimeout(function() {
		        srLink.focus();
		   }, 600)
		}
	}
	
	// set the input focus to the beginning of the header section to get around an issue where screen reader reads from the navigation panel.
	// This will allow the user to use the "Skip to main content" link
	if (errorTable == null && tconfirmLink == null && terrorLink == null && srLink == null && 
	    !(document.getElementById("im-submit-javascript") != null && document.getElementById("im-submit-nojavascript") != null)) {
		var headerStartLink = document.getElementById("headerstartlink");
		if (headerStartLink != null) {
			setTimeout(function() {
		        headerStartLink.focus();
		   }, 600)
		}
	}	
});


function logout() {
	for ( var i = 0 ; i < categoryArray.length ; i++ ) {
		Ext.state.Manager.clear(categoryArray[i].stateId);
	}
	Ext.state.Manager.clear('cat2');
	Ext.state.Manager.clear('cat3');
	return true;
}


function setTitleForPanelToggle(panel) {
	var toggleToolClass = 'x-tool-collapse-west';
	var toggleToolTitle = '<%= hideTasks %>';
	if (panel.collapsed) {
		toggleToolClass = 'x-tool-expand-west';
		toggleToolTitle = '<%= showTasks %>';
	}
	setTitleForCSSClass(toggleToolClass, toggleToolTitle);
}


function setTitleForCSSClass(cssclass, title) {
    var aryClassElements = imGetElementsByClassName(cssclass, document.body);
    for ( var i = 0; i < aryClassElements.length; i++ ) {
	    if (aryClassElements[i].title.length == 0) {
			aryClassElements[i].title = title;
	    }
    }
}
</script>

<style type="text/css">
.ca-gray-head .x-panel-header-text a {
    color: #1c73b8;
    text-decoration:none;
}

img.logo {
	vertical-align: middle;
}
/* override castyles to prevent underline in ext-js buttons */
em {
	text-decoration:none;
}

.skiplinks a {
	color: white;
}

.skiplinks  a:active,
.skiplinks  a:focus,
.skiplinks  a:hover  {
    text-decoration:underline;
}

.im-page-section-header h1 {
	font-size: 12px;
	color: white;
}

#startcontent {
	color: white;
}

.im-page-section-header h2 {
	background: none;
	background-image: none;
	border-bottom: none;
	border-left: none;
	border-right: none;
	border-top:none;	
	color: white !important;
	font-size: 12px;
	padding-bottom: 0px;
	padding-top: 0px;
	padding-left: 0px;
	padding-right: 0px;
}

.im-page-section-header A {
	color: white;
}

h2 {
	background: #627593;
}

.im-page-section-header {
	background-image: none;
	background-color: #82020B;	
	border-top-color: white;
	border-left-color: white;
	border-right-color: white;
	border-bottom-color: white;
}		

.x-panel-header {
	background-image: none;
	background-color: #256E99;
}

.ca-gray-head .x-panel-header {  
	background-image: none;
	background-color: #F5F3F6;
}

.im-error, .im-error-msg {	
	color: #DE0000;	
}

.ca-footer-linktext {
	color: #5577B1;
}

.ca-footer-copytext {
	color: #707070;
}

.wizard-step-label-active,
.wizard-step-label-active a,
.wizard-step-label-active .im-button-link,
.wizard-step-label-active .im-button-link-hover {
	color: #B13636;
}

.wizard-step-label-inactive,
.wizard-step-label-inactive a,
.wizard-step-label-inactive .im-button-link,
.wizard-step-label-inactive .im-button-link-hover {
	color: #1F5FFF;
}

.x-btn-tl,.x-btn-tr,.x-btn-tc,.x-btn-ml,.x-btn-mr,.x-btn-mc,.x-btn-bl,.x-btn-br,.x-btn-bc {	
	background-image: none;
	background-color: #3372E4;	
}

.ca-gray .x-btn-tl,.ca-gray .x-btn-tr,.ca-gray .x-btn-tc,.ca-gray .x-btn-ml,.ca-gray .x-btn-mr,.ca-gray .x-btn-mc,.ca-gray .x-btn-bl,.ca-gray .x-btn-br,.ca-gray .x-btn-bc {
  	background-image: none;
  	background-color: #777771;
}

.x-panel-header .x-unselectable .x-accordion-hd {
	background-image: none;
	background-color: #F3F3F6;
}

input[type='checkbox']:focus,
input[type='checkbox']:active {
  border: dotted thin black;
} 
        
</style>
</head>
<body onbeforeunload="clearTimeout(setTimeoutVar);">
<!-- ### Begining FFX Header Section #####-->
<div id="north">
<div style ="min-width: 1000px; width:100%">
<div id="header">
  
	  <div id="logo">
	      <img src="/resources/public/web/templates/images/interface/logo.gif" border="0" alt="Fairfax County, Virginia">
	  </div>
	  <div id="slideshowImage">
		  <img src="/resources/public/web/templates/images/header/image0.jpg" name="myImage" id="myImage" alt="Fairfax County<%=" " + hostNumber%>" align="right">
	  </div>
  </div>
  </div>
  <div id="navbar">
    <div id="searcharea">
       <form name="gs"  method="GET" action="/search">
	     <input type="hidden" name="thishost" value="<%=hostName + " " + hostNumber%>" /> 
         <input type="hidden" name="site" value="default_collection" /> 
		 <input type="hidden" name="client" value="default_frontend" />
         <input type="hidden" name="output" value="xml_no_dtd" /> 
         <input type="hidden" name="proxystylesheet" value="default_frontend" /> 
         <input type="hidden" name="filter" value="p" /> 
         <input type="hidden" name="getfields" value="*" />
         <label><strong>Search Site:</strong></label>
         <input type="text" style="width: 160px;" name="q"  class="textbox" tabindex="1" size="32"  maxlength="150" value=""/>
         <input type="submit" name="btnG" value="Go" class="button-topsearchgo" tabindex="2" />
    </form>
    <form name="gs"  method="GET" action="/search">
         <input type="hidden" name="q" value="" />
         <input type="submit" name="btnAdvance" value="Advanced Search" class="button-topsearch" tabindex="3" />
         <input type="hidden" name="site" value="default_collection" />
         <input type="hidden" name="client" value="default_frontend" />
         <input type="hidden" name="output" value="xml_no_dtd" />
         <input type="hidden" name="output" value="xml_no_dtd" />
         <input type="hidden" name="proxystylesheet" value="default_frontend" />
         <input type="hidden" name="access" value="p" />
         <input type="hidden" name="getfields" value="*" />
         <input type="hidden" name="entqr" value="0" />
         <input type="hidden" name="lr" value="lang_en" />
         <input type="hidden" name="ud" value="1" />
         <input type="hidden" name="proxycustom" value="&lt;ADVANCED/&gt;" />
    </form>
  </div>
  <div id="mainMenu">
    <a name="audiencenav"></a>
      <ul id="menuList">
        <li id="mainMenuHome" class="bodytextsmall">
          <a href="/" accesskey="1">Home</a>
        </li>
        <li id="mainMenuLiving" class="bodytextsmall">
          <a href="/living/" accesskey="2">Living Here</a>
        </li>
        <li id="mainMenuBusiness" class="bodytextsmall">
          <a href="/business/" accesskey="4">Doing Business</a>
        </li>
        <li id="mainMenuVisiting" class="bodytextsmall">
          <a href="/visitors/" accesskey="3">Visiting</a>
         </li>
        <li id="mainMenuGovernment" class="bodytextsmall">
          <a href="/government/departments/" accesskey="5">Departments &amp; Agencies</a>
        </li>
      </ul>
  </div>
</div>
<div id="statusbar">
<div id="username">

</div>

<div id="help-logout">
<div class="app-login-help" style="margin-top:-13px;">
			<h4>  
			<skin:ifprotected>	
			<span id="ctl00_lblUser"> 		
			<skin:userattribute var="loginName" attribute="%FULL_NAME%" />
			<% if (loginName == null || loginName.equals("")) { %>
			<skin:userattribute var="userID" attribute="%USER_ID%" />
			<% loginName = userID; %>
			<% } %>
			<skin:img src="head_icon.gif" alt="User" title="User" width="10" height="11" /> <span class="headerTxt"><%= loginName %></span>
			  <span class="headerPipe">|</span>
			  <!--  <skin:logout styleClass="logout" onclick="return logout();"><skin:message key="console.logout" /></skin:logout> -->
			  <a id="ctl00_hypProfile" class="linkover" href="/iam/im/ctz/ffx/index.jsp?task.tag=ChangeMyPassword">Change Password</a>	
			  <span class="headerPipe">|</span>
			</span> 
				 <a id="ctl00_hypProfile" class="linkover" href="/iam/im/ctz/ffx/index.jsp?task.tag=ModifyMyProfile">Profile</a>				    
				 &nbsp;|&nbsp; 
				 <a id="ctl00_hypMyFairfaxMenu" class="linkover" href="/myfairfax/">MyFairfax Menu</a>
			</skin:ifprotected>
			</h4>    
</div>
</div>
</div>
</div>


<!-- ### Ending FFX Header Section. #####-->

<skin:themetitle var="title" />


<% if (!suppressTaskNavigation) { %>



<% int catid = 1; %>

<%
    int catCounter = 0;
	String parentMenu = "";
    String tasksCategory = Localizer.getInstance().getLocalizedString("imstask.label.tab.tasks");
%>

<%
	for (String catname : categories) {
%>
<% String divid = "west" + catid++; %>
    <div id="<%= divid %>" class="x-hide-display" style="margin-left: .5em;">

<ul class="x-tree-node">

<%
	if (catid == 2) {
%>  
	<skin:ifenvproperty property="ShowHomeLink">
	<li style="white-space: nowrap;">
	<div class="x-tree-node-item">
	<skin:home onclick="return selectMenu(this);"><img alt="" title="" src="ca/images/arrow_normal.gif" border="0" align="bottom"/><skin:message key="console.home"/></skin:home>
	</div>
	</li>
	</skin:ifenvproperty>
<%
	}
%>

<skin:categories category1="<%= catname %>" type="all">
 	<skin:category var="cat2name" />

<% 
String cat2localized = Localizer.getInstance().getConditionallyLocalizedString(cat2name);
if (!"Tasks".equals(cat2name) && !tasksCategory.equalsIgnoreCase(cat2name) && !tasksCategory.equalsIgnoreCase(cat2localized)) { 
    catCounter++;
%>
 	
    <li>
        <%
            String elemClass2 = "sidenavmenu_unselected";
            String displayStyle2 = "none";
			String catImg2 = "ca/images/arrow.png";
			parentMenu = String.valueOf(catCounter);
        %>
	<div class="x-tree-node-item">
		<a href="#" id="m-<%= catCounter %>" class="<%=elemClass2%>" onclick="toggleMenu('<%= catCounter %>');" title="<%= cat2name %>"><img id="mi-<%= catCounter %>" alt="" title="" src="<%= catImg2 %>" border="0" align="bottom"/><skin:category /></a>
		<div style="margin-left: 1em;">
		<ul id="mp-<%= catCounter %>" class="submenu-show" style="height: auto; display: <%=displayStyle2%>">


<%
	}
	else {
		parentMenu = "";
	}
%>

	<skin:categories type="all">
		<skin:category var="cat3name" />
<%
    catCounter++;
%>

		<li>
        <%
            String elemClass3 = "sidenavmenu_unselected";
            String displayStyle3 = "none";
			String catImg3 = "ca/images/arrow.png";
        %>
		<div class="x-tree-node-item">
			<a href="#" id="m-<%= catCounter %>" class="<%=elemClass3%>" onclick="toggleMenu('<%= catCounter %>', '<%= parentMenu %>');" title="<%= cat3name %>"><img  id="mi-<%= catCounter %>" alt="" title="" src="<%= catImg3 %>" border="0" align="bottom"/><skin:category /></a>
			<div style="margin-left: 1em;">
			<ul id="mp-<%= catCounter %>" class="submenu-show" style="height: auto; display: <%=displayStyle3%>">

			<skin:tasks>
			<skin:taskname var="taskname" />
			<li style="white-space: nowrap;">
			<skin:task onclick="return selectMenu(this);" title="<%= taskname %>"><img alt="" title="" src="ca/images/arrow_normal.gif" border="0" align="bottom"/><skin:taskname /></skin:task>
			</li>
			</skin:tasks>

			</ul>
			</div>
		</div>
		</li>
	</skin:categories>
	
	
    <skin:tasks>
    <skin:taskname var="taskname2" />
	<li style="white-space: nowrap;">
    <skin:task onclick="return selectMenu(this);" title="<%= taskname2 %>"><img alt="" title="" src="ca/images/arrow_normal.gif" border="0" align="bottom"/><skin:taskname /></skin:task>
    </li>
    </skin:tasks>


<% 
if (!"Tasks".equals(cat2name) && !tasksCategory.equalsIgnoreCase(cat2name) && !tasksCategory.equalsIgnoreCase(cat2localized)) { 
%>
    </ul>
	
</div>
</div>

    </li>

<% } %>

  </skin:categories>
    

<%-- TODO: fix TasksTag category1 recurse issue (requires new attribute and change to legacy consoles) --%>
<skin:tasks category1="<%= catname %>" type="all">
    <skin:taskname var="taskname3" />
	<li style="white-space: nowrap;">
<div class="x-tree-node-item">
	<skin:task onclick="return selectMenu(this);" title="<%= taskname3 %>"><img alt="" title="" src="ca/images/arrow_normal.gif" border="0" align="bottom"/><skin:taskname /></skin:task>
</div>
  </li>
</skin:tasks>


</ul>

    </div>
<%
	}
%>


<%
    String disableAutoCancelSetting = (String) com.netegrity.webapp.UIContext.getImsEnvironment(request).getEnvironmentSettingsProvider().getEnvironmentUserDefinedPropertiesDefinition().getUserProperties().get("ConsoleDisableAutoTaskCancel");
    boolean autoTaskCancel = true;
    if (disableAutoCancelSetting != null) {
	    if ("1".equals(disableAutoCancelSetting) || "true".equalsIgnoreCase(disableAutoCancelSetting) || "on".equalsIgnoreCase(disableAutoCancelSetting)) {
		    autoTaskCancel = false;
	    }
    }
%>


<script type="text/javascript">
<!--
    function selectMenu(elem) {
	
<% if (autoTaskCancel) { %>
		if (!imConfirmation(elem.href)) {
			return false;
		}
<% }	 
%>
        if (elem.className == 'sidenavlink_unselected') {
            elem.className = 'sidenavlink_selected';
        }
        else {
            elem.className = 'sidenavlink_unselected';
        }
        
        return true;
    }

    function hideMenus(currentMenu, parentmenu) {
<% for (int i=1 ; i < catCounter ; i++) { %>
		menulink = 'm-<%= i %>';
		menu = 'mp-<%= i %>';
		menuimg = 'mi-<%= i %>';
		if (menu != currentMenu && menu != parentmenu) {
			document.getElementById(menulink).className = 'sidenavmenu_unselected';
			document.getElementById(menu).style.display = "none"; // collapse list
			document.getElementById(menuimg).src = 'ca/images/arrow.png';
		}
<% } %>
    }

    // this function toggles the status of a list
    function toggleMenu(elemid, parent) {
        var melem = document.getElementById('m-' + elemid);
		var mielem = document.getElementById('mi-' + elemid);
        if (melem.className == 'sidenavmenu_unselected') {
            melem.className = 'sidenavmenu_selected';
			mielem.src = 'ca/images/arrow_asc_bk.png';
			if (parent == null) {
				Ext.state.Manager.set('cat2', elemid);
				Ext.state.Manager.clear('cat3');
			}
			else {
				Ext.state.Manager.set('cat2', parent);
				Ext.state.Manager.set('cat3', elemid);
			}
        }
        else {
            melem.className = 'sidenavmenu_unselected';
			mielem.src = 'ca/images/arrow.png';
			if (parent == null) {
				Ext.state.Manager.clear('cat2');
				Ext.state.Manager.clear('cat3');
			}
			else {
				Ext.state.Manager.clear('cat3');
			}
        }
		var list = document.getElementById('mp-' + elemid);
		var listElementStyle = list.style;

		if (parent == null) {
			hideMenus('mp-' + elemid);
		}
		else {
			hideMenus('mp-' + elemid, 'mp-' + parent);
		}
        
        if (listElementStyle.display=="none") {
            listElementStyle.display="block";
        }
        else {
            listElementStyle.display="none";
        }
    }
//-->
</script>

<% } %>


<div id="center1" style="margin: 0; padding: 0; border: none;" class="x-hide-display">
<div id="content" style="border: none;">

<skin:iftaskpage>

<skin:ifpublic>

<table style="margin-left: auto; margin-right: auto;">
<tr><td>
<label class="ca-section-title"><a name="startcontent" id="startcontent"><skin:tasktitle /></a></label>
</td></tr>
<tr><td>
<skin:taskbody />
</td></tr>
</table>

</skin:ifpublic>

<skin:ifprotected>
<table cellpadding="0" cellspacing="0" style="width: 100%;"><tr><td>
	<div class="im-page-section-header"><h1><span name="startcontent" id="startcontent"><skin:tasktitle /></span></h1></div>
	<table cellpadding="0" cellspacing="10" style="width: 100%;"><tr><td>
	<skin:taskbody />
	</td></tr></table>
</td></tr></table>
</skin:ifprotected>

</skin:iftaskpage>

<skin:ifhomepage>
  <jsp:include page="home.jsp" flush="true" />
</skin:ifhomepage>

<skin:iferrorpage>
  <skin:fragmentinclude defaultPage="home.jsp" />
</skin:iferrorpage>

<skin:ifconfirmationpage>
  <skin:fragmentinclude defaultPage="home.jsp" />
</skin:ifconfirmationpage>

</div>
</div>
<div id="south" class="x-hide-display">
<!-- ### Begining FFX Footer Section #####-->
    <div id="footersite" valign="center" style="margin-top:-32px;">
        <a name="footer"></a>
        <p style="margin-top:55px;">
            <strong>Contact Fairfax County:</strong>&nbsp;<a href="http://www.fairfaxcounty.gov/opa/contact/">Phone, Email or Twitter</a>&nbsp;<span class="separator">|</span>&nbsp;<strong>Main Address:</strong>&nbsp;<a href="http://www.fairfaxcounty.gov/maps/county/government-center.htm">12000 Government Center Parkway</a>, Fairfax, VA 22035<br />
            <strong>Technical Questions:</strong>&nbsp;<a href="http://www.fairfaxcounty.gov/contact/MailForm.aspx?agId=100387">Web Administrator</a>
        </p>
        <p>
            <a href="http://www.fairfaxcounty.gov/living/accessibility/">ADA Accessibility</a>
            <span class="separator">|</span>
            <a href="http://www.fairfaxcounty.gov/using/accessibility.htm">Website Accessibility</a>
            <br />
            <a href="http://www.fairfaxcounty.gov/opa/awards/">Awards</a>
            <span class="separator">|</span>
            <a href="http://www.fairfaxcounty.gov/opa/foia.htm">FOIA</a>
            <span class="separator">|</span>
            <a href="http://m.fairfaxcounty.gov/">Mobile</a>
            <span class="separator">|</span>
            <a href="http://www.fairfaxcounty.gov/using/">Using this Site</a>
            <span class="separator">|</span>
            <a href="http://www.fairfaxcounty.gov/using/privacy.htm">Web Disclaimer &amp; Privacy Policy</a>
            <span class="separator">|</span>
            <a href="http://get.adobe.com/reader/">Get Adobe Reader</a>
            <br/>
            Official site of the County of Fairfax, Virginia, &copy; Copyright 2013<br/>
        </p>
    </div>
<!-- ### Ending FFX Footer Section. #####-->
</div>
</div>

</f:view>
<style type="text/css"> #searcharea { font-weight: bold; } </style>
</body>
</html>
