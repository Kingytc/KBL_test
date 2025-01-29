<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String strStatus=Helper.correctNull((String)hshValues.get("APP_REVALSTATUS"));
if(strStatus.equalsIgnoreCase("op"))
	strStatus="Pending"; 
else if(strStatus.equalsIgnoreCase("pa"))
	strStatus="Approved";
else if(strStatus.equalsIgnoreCase("pr"))
	strStatus="Rejected";
else if(strStatus.equalsIgnoreCase("ps"))
	strStatus="Sent Back for ReWork";
else
	strStatus="";
ArrayList arrBankRow1=(ArrayList)hshValues.get("arrDoc");
out.println(hshValues);
%>
<html>
<head>
<title>Revalidation</title>
<script>
var usr_class="";
var usr_func = "";
var usr_dept="";
var flag="";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var btnenable="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>";
var struserpower="<%=Helper.correctNull((String) hshValues.get("strUserClass"))%>";
var struserID="<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>";
var strprd_power="<%=Helper.correctNull((String) hshValues.get("strAuthority"))%>";
console.log();
var strstatus="<%=Helper.correctNull((String) hshValues.get("APP_STATUS"))%>";
var strAutUser="<%=Helper.correctNull((String) hshValues.get("APP_PROCESSEDBY"))%>";
var strUserID_app="<%=Helper.correctNull((String) hshValues.get("APP_CREATEDBY"))%>";
var strUser_revalidate="<%=Helper.correctNull((String) hshValues.get("APP_REVALIDATEDBY"))%>";
console.log("User_Name"+strUser_revalidate);
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("strRecordFlag"))%>";
var varStatus="<%=Helper.correctNull((String) hshValues.get("strStatus"))%>";
var varAccFlag="<%=Helper.correctNull((String) hshValues.get("strAccFlag"))%>";
var userorglevel="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>";
var strdocviewstatus="<%=Helper.correctNull((String) hshValues.get("strdocviewstatus"))%>";

function doClose()
{
	if( ConfirmMsg(100) )
	{
		window.close();
	}
}

function disableCommandButtons(bool1,bool2,bool3,bool4,bool5,bool6,bool7,bool8)
{
	debugger
	console.log("disableCommandButtons");
		document.forms[0].cmdedit.disabled=bool1;
		document.forms[0].cmdsend.disabled=bool2;
	  	document.forms[0].cmdsave.disabled=bool3;
	  	document.forms[0].cmdcancel.disabled=bool4;
	  	document.forms[0].cmdclose.disabled=bool5;
	  	document.forms[0].cmdapprove.disabled=bool6;
	  	document.forms[0].cmdreject.disabled=bool7;
	  	document.forms[0].cmdsendbacktobranch.disabled=bool8;
}

function onLoading()
{
	debugger
	console.log("Onloading");
	callDisable(true);
	document.forms[0].usr_department.disabled=false;
	if(varStatus=="send")
	{
		alert("Request sent Successfully");
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].action=appURL+"action/appworkflowaction.jsp";
		document.forms[0].submit();
		window.close();
	}
	else if(varStatus=="approve")
	{
		alert("Request Approved Successfully");
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].action=appURL+"action/appworkflowaction.jsp";
		document.forms[0].submit();
		window.close();
	}
	else if(varStatus=="reject")
	{
		alert("Request Rejected");
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].action=appURL+"action/appworkflowaction.jsp";
		document.forms[0].submit();
		window.close();
	}
	else if(varStatus=="sendback")
	{
		alert("Request Sent Back for Rework to User "+strUserID_app);
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].action=appURL+"action/appworkflowaction.jsp";
		document.forms[0].submit();
		window.close();
	}
	
 		if(document.forms[0].org_name.value=="HEAD OFFICE"){

		document.all.deprt1.style.visibility="visible";
		document.all.deprt1.style.position="relative";
		document.all.deprt2.style.visibility="visible";
		document.all.deprt2.style.position="relative";
		}
		else
		{
		document.all.deprt1.style.visibility="hidden";
		document.all.deprt1.style.position="absolute";
		document.all.deprt2.style.visibility="hidden";
		document.all.deprt2.style.position="absolute";
		}
		//EditorEnableDisable("id_div","block","id_editor","none");
		EditorEnableDisable("id_div1","block","id_editor1","none");
		//EditorEnableDisable("id_div3","block","id_editor3","none");
		EditorEnableDisable("id_div4","block","id_editor4","none");
		EditorEnableDisable("id_div5","block","id_editor5","none");
		EditorEnableDisable("id_div6","block","id_editor6","none");
		if(strUser_revalidate==struserID)
		{
			disableCommandButtons(false,true,true,true,false,true,true,true);
			if(varRecordFlag=="Y")
			{
				document.forms[0].cmdsend.disabled=false;
			}
		}
		else if(strUser_revalidate=="" && struserID==document.forms[0].appholder.value)
		{
			disableCommandButtons(false,true,true,true,false,true,true,true);
			if(varRecordFlag=="Y")
			{
					document.forms[0].cmdsend.disabled=false;
			}
		}
		else
		{
			document.forms[0].cmdsend.disabled=true;
			document.forms[0].cmdapprove.disabled=true;
			document.forms[0].cmdreject.disabled=true;
			if(varRecordFlag=="Y" && userorglevel!="A")
			{
				document.forms[0].cmdsendbacktobranch.disabled=false;
			}	
			else
			{
			document.forms[0].cmdsendbacktobranch.disabled=true;
			}
		}

		if(strstatus=="pa"||strstatus=="pr")
		{
			if(userorglevel!="A")
			{ 
			disableCommandButtons(true,true,true,true,false,true,true,false);
			}
			else
			{
				disableCommandButtons(true,true,true,true,false,true,true,true);
			}
			document.forms[0].cmdundo.disabled=true;
			if(strUser_revalidate==struserID)
			{
				document.forms[0].cmdundo.disabled=false;
			}
		}
		else if(strstatus=="ps")
		{//alert(77) 
			//alert(strUser_revalidate)
			//alert(struserID)
			if(strUser_revalidate==struserID)
			{
				disableCommandButtons(false,false,true,true,false,true,true,true);//shiva
			}
			else
			{
				disableCommandButtons(true,true,true,true,false,true,true,true);
			}
			document.forms[0].cmdundo.disabled=true;
			
			/* if(strUser_revalidate==struserID)
			{
				document.forms[0].cmdundo.disabled=false;
			} */
		}
		else
		{
			document.forms[0].cmdundo.disabled=true;
		}
		if(varAccFlag=="Y")
		{
			document.forms[0].cmdundo.disabled=true;
		}
}

function doEdit()
{ 	
	debugger
	console.log("DoEdit");
	callDisable(false);
	debugger
	console.log("Doedit_2")
	document.forms[0].usr_department.disabled=false;
	if(strUser_revalidate!=struserID )	
	{
	//if(parseInt(struserpower)>=parseInt(strprd_power))
	{
	
		/*EditorEnableDisable("id_div","none","id_editor","block");
		editor_generate('txtarea_comments');*/
		EditorEnableDisable("id_div6","none","id_editor6","block");
		editor_generate('txt_reasonfordelay');	
 		EditorEnableDisable("id_div1","block","id_editor1","none");
		}
	}
	//alert(struserpower)
	//alert(strprd_power)
	/* if(parseInt(struserpower)>=parseInt(strprd_power)){
		
		EditorEnableDisable("id_div3","none","id_editor3","block");
		editor_generate('txtarea_comments3');
		} */
	
	/* EditorEnableDisable("id_div6","none","id_editor6","block");
	editor_generate('txt_reasonfordelay');	
	 */
	EditorEnableDisable("id_div5","none","id_editor5","block");
	editor_generate('txt_branchrecomend');
	
	 if(document.forms[0].org_level.value!="A")
		{
	EditorEnableDisable("id_div4","none","id_editor4","block");
	editor_generate('txt_deptrecomend');
		}
	
	//else
	if(strUser_revalidate==struserID )	
	{	if(userorglevel!="A")
		{
			EditorEnableDisable("id_div1","none","id_editor1","block");
			editor_generate('txtarea_comments1');
		}
	else
		{
			EditorEnableDisable("id_div1","block","id_editor1","none");
		}
		if(varRecordFlag=="Y")
		{	
			/* EditorEnableDisable("id_div","none","id_editor","block");
	 		editor_generate('txtarea_comments'); */
	 		EditorEnableDisable("id_div6","none","id_editor6","block");
			editor_generate('txt_reasonfordelay');	
		}
		else
		{
			EditorEnableDisable("id_div1","block","id_editor1","none");
		}
		if(strUser_revalidate==struserID && strstatus=="ps")		
		{
			document.forms[0].cmdsend.disabled=false;
		}
		else if(strUser_revalidate==struserID && strstatus=="op")		
		{
			document.forms[0].cmdsend.disabled=false;
		}
		else
		{
 		document.forms[0].cmdsend.disabled=true;
		}
	}
	if(strUser_revalidate!=struserID ) //error
	{
		if(parseInt(struserpower)>= parseInt(strprd_power))
		{
			disableCommandButtons(true,true,false,false,true,true,true,true);
			
		}
		else
		{
			disableCommandButtons(true,true,true,false,true,true,true,true);
		}
	}
	else if(strUser_revalidate==struserID )
		{
			if(parseInt(struserpower)>= parseInt(strprd_power))
			{	if(userorglevel!="A")
				{//alert(88)
					disableCommandButtons(true,true,false,false,true,false,false,false);
				}
			else
				{
					disableCommandButtons(true,true,false,false,true,true,true,true);
				}
				
			}
			else
			{
				disableCommandButtons(true,true,false,false,true,true,true,true);
			}
		}
	
	
	if(varRecordFlag!="Y")
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
		document.forms[0].cmdsendbacktobranch.disabled=true;
	}
	document.forms[0].txt_revalidreqdt.readOnly=true;
	document.forms[0].txt_name.readOnly=true;
	document.forms[0].txt_desig.readOnly=true;
	document.forms[0].txt_desig1.readOnly=true;
	document.forms[0].txt_date.readOnly=true;
	document.forms[0].txt_sancname.readOnly=true;
	document.forms[0].txt_sancdesig.readOnly=true;
	document.forms[0].txt_sancdesig1.readOnly=true;	
	document.forms[0].txt_sancdate.readOnly=true;
	
}

function doSend()
{
	debugger
	console.log("DoSend");
	var receipientclass="";
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(112,"Select Recipient");	
		return ;
	}
	if(document.forms[0].hidmail_tousrid.value==struserID)
	{
		alert("From User and Recipient User are Same");	
		return ;
	} 
	 if(document.forms[0].org_level.value=="C")
		{
			receipientclass="<%=Helper.correctNull((String) hshValues.get("strAuthorityHO"))%>"
		}
	else if(document.forms[0].org_level.value=="R")
	{
			receipientclass="<%=Helper.correctNull((String) hshValues.get("strAuthorityRO"))%>"
	}
	else if(document.forms[0].org_level.value=="D")
	{
			receipientclass="<%=Helper.correctNull((String) hshValues.get("strAuthorityRLPSC"))%>"
	}
	else if(document.forms[0].org_level.value=="A")
	{
			receipientclass="<%=Helper.correctNull((String) hshValues.get("strAuthoritybranch"))%>"
	}
	//alert(document.forms[0].org_level.value)
	/*if(document.forms[0].org_level.value=="A")
	{
		alert("Branch User doesn't have power for Revalidation Verification, Kindly select other user ");			
		document.forms[0].mail_tousrid.value==""
		document.forms[0].mail_tousrid.focus();
		return ;
	}*/
	
	/*if(parseInt(document.forms[0].mail_touserclass.value)<parseInt(receipientclass)) 
	{ 
		alert("Selected Recipient doesn't have power to Revalidate the proposal ");	
		document.forms[0].mail_tousrid.value==""
		document.forms[0].mail_tousrid.focus();
		return ;
	}*/
	

	<%if(arrBankRow1!=null && arrBankRow1.size()>0)
	{
		if(!arrBankRow1.contains("REVAL")){ %>
	
			alert("Please Upload Document under Post sanction Document Attachment tab - Other Documents - SANCTION REVALIDATION CUSTOMER REQUEST AND BRANCH RECOMMENDATION");
			return;
	
	<%}
	} else
		{%>
			alert("Please Upload Document under Post sanction Document Attachment tab - Other Documents - SANCTION REVALIDATION CUSTOMER REQUEST AND BRANCH RECOMMENDATION");
			return;
		<%}%>
	if(document.forms[0].txt_name.value=="")
	{
		alert("Select Appraised By ");	
		document.forms[0].txt_name.focus();
		return ;
	}
	if(document.forms[0].txt_sancname.value=="")
	{
		alert("Select Sanctioned By ");	
		document.forms[0].txt_sancname.focus();
		return ;
	}
		document.forms[0].hidAction.value="send";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
		document.forms[0].action=appURL+"action/revalidatecomments.jsp";
		document.forms[0].submit();
}

function doSave()
{
	debugger
	console.log("Dosave");
	if(document.forms[0].txt_revalidreqdt.value=="")
	{
		ShowAlert(111,"Date of Revalidation request received");
		document.forms[0].txt_revalidreqdt.focus();
		return;
	}
	if(strUser_revalidate!=struserID )	
	{
		if(parseInt(struserpower)>=parseInt(strprd_power)){
	 var messageLength1 = CKEDITOR.instances['txt_reasonfordelay'].getData().replace(/<[^>]*>/gi, '').length;
    if( !messageLength1 ) {
        alert( 'Enter Reason for Revalidation and Delay in facility availing' );
        return;
    } 
		}
	}
	var messageLength1 = CKEDITOR.instances['txt_branchrecomend'].getData().replace(/<[^>]*>/gi, '').length;
    if( !messageLength1 ) {
        alert( 'Enter Branch Recommendation' );
        return;
    }
    if(document.forms[0].org_level.value!="A")
	{
		var messageLength1 = CKEDITOR.instances['txt_deptrecomend'].getData().replace(/<[^>]*>/gi, '').length;
	    if( !messageLength1 ) {
	        alert( 'Enter Department comments and recommendation' );
	        return;
	    }
	}
	if(document.forms[0].txt_revalidcharges.value=="")
	{
		ShowAlert(121,"Revalidation Charges");
		document.forms[0].txt_revalidcharges.focus();
		return;
	}
	
	/* if(parseInt(struserpower)>=parseInt(strprd_power)){
	
	var messageLength1 = CKEDITOR.instances['txtarea_comments3'].getData().replace(/<[^>]*>/gi, '').length;
    if( !messageLength1 ) {
        alert( 'Enter Approving Authority Comments' );
        return;
    }    
	
	} */
	
			if(strUser_revalidate==struserID )
			{
				if(userorglevel!="A")
				{
		    	var messageLength1 = CKEDITOR.instances['txtarea_comments1'].getData().replace(/<[^>]*>/gi, '').length;
			    if( !messageLength1 ) {
			        alert( 'Enter Revalidation Approval Comments' );
			        return;
			 	}
				}
		    }
		
	/* else{
    	var messageLength = CKEDITOR.instances['txtarea_comments'].getData().replace(/<[^>]*>/gi, '').length;
    	if( !messageLength ) {
            alert( 'Enter Reason for Revalidation' );
            return;
        }
    } */
    if(document.forms[0].txt_name.value=="")
	{
		alert("Select Appraised By ");	
		document.forms[0].txt_name.focus();
		return ;
	}
	if(document.forms[0].txt_sancname.value=="")
	{
		alert("Select Sanctioned By ");	
		document.forms[0].txt_sancname.focus();
		return ;
	}
	if(document.forms[0].txt_date.value=="")
	{
		alert("Select Appraised Date ");	
		document.forms[0].txt_date.focus();
		return ;
	}
	if(document.forms[0].txt_sancdate.value=="")
	{
		alert("Select Sanctioned Date ");	
		document.forms[0].txt_sancdate.focus();
		return ;
	}
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
		document.forms[0].action=appURL+"action/revalidatecomments.jsp";
		document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanGetMethod.value="getRevalidateComments";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].action=appURL+"action/revalidatecomments.jsp";	
		document.forms[0].submit();
	}
}

function callLink1(page,bean,method)
{
	debugger
	console.log("callLink1");
	if(document.forms[0].cmdsave.disabled==true)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
}
function callOrgHelp()
{
	var appno1="<%=Helper.correctNull((String) hshValues.get("appno"))%>";
	if(document.forms[0].cmdedit.disabled==false){
		var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
		var url=appURL+"action/orgnamelist.jsp?&appno="+appno1;
		window.open(url,"",prop);
	}
}
function callUsersHelp()
{
	if(document.forms[0].cmdedit.disabled==false){
	if(document.forms[0].org_name.value=="HEAD OFFICE")
	{
		if(document.forms[0].usr_department.value=="0")
		{
			ShowAlert(111,"Department");
			document.forms[0].usr_department.focus();
			return;
		}
	}
	usr_dept=document.forms[0].usr_department.value;
	var prop="scrollbars=no,width=400,height=350,top=100,left=250";
	var url=appURL+"action/wrkflowuserlist.jsp?usr_class="+usr_class+"&org_code="+document.forms[0].org_code.value+"&usr_dept="+usr_dept+"&pagefrom=REVAL";
	window.open(url,"hai",prop);
	}
}
function doApprove()
{
	debugger
	console.log("DoApprove");
	//alert(strdocviewstatus)
	if(strdocviewstatus!="Y")
	{
		 	alert( 'Kindly View the Documents Tab to Proceed with Approval..' );
	        return;
	}
	var messageLength = CKEDITOR.instances['txt_reasonfordelay'].getData().replace(/<[^>]*>/gi, '').length;
	if( !messageLength ) {
        alert( 'Enter Reason for Revalidation' );
        return;
    }
	if(userorglevel!="A")
	{
		var messageLength1 = CKEDITOR.instances['txtarea_comments1'].getData().replace(/<[^>]*>/gi, '').length;
	    if( !messageLength1 ) {
	        alert( 'Enter Revalidation Approval Comments' );
	        return;
	    }
	}
	document.forms[0].hidAction.value="approve";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
	document.forms[0].action=appURL+"action/revalidatecomments.jsp";
	document.forms[0].submit();
}
function doReject()
{
	if(userorglevel!="A")
	{
	   	var messageLength1 = CKEDITOR.instances['txtarea_comments1'].getData().replace(/<[^>]*>/gi, '').length;
	    if( !messageLength1 ) {
	        alert( 'Enter Revalidation Approval Comments' );
	        return;
	    }
	}
	document.forms[0].hidAction.value="reject";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
	document.forms[0].action=appURL+"action/revalidatecomments.jsp";
	document.forms[0].submit();
	
}
function doUndo()
{
	
	document.forms[0].hidAction.value="undo";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
	document.forms[0].action=appURL+"action/revalidatecomments.jsp";
	document.forms[0].submit();
}
function doSendBackToBranch()
{	//alert(9)
	if(userorglevel!="A")
	{
	   	var messageLength1 = CKEDITOR.instances['txtarea_comments1'].getData().replace(/<[^>]*>/gi, '').length;
	    if( !messageLength1 ) {
	        alert( 'Enter Revalidation Approval Comments' );
	        return;
	    }
	}
	document.forms[0].hidAction.value="sendback";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
	document.forms[0].action=appURL+"action/revalidatecomments.jsp";
	document.forms[0].submit();
	
}
function callCalender1(name)
{	
	debugger
	console.log("callCalender1");
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

function changeDateformat(dateStr) {
    var parts = dateStr.split('/');
    return new Date(parts[2], parts[1] - 1, parts[0]);
}
 
function formatDateToDDMMYYYY(date) {
    var day = ("0" + date.getDate()).slice(-2);
    var month = ("0" + (date.getMonth() + 1)).slice(-2);
    var year = date.getFullYear();
    return day + "/" + month + "/" + year;
}
 
function checkreqdate() {
	dubugger
	console.log("checkreqdate");
    var currentDateStr = "<%=Helper.getCurrentDateTime()%>"; 
    var reqdateStr = document.forms[0].txt_revalidreqdt.value;
 
    if (!reqdateStr) {
        return;
    }
    var currentDate = changeDateformat(currentDateStr);
    var reqdate = changeDateformat(reqdateStr);
 
    var pastDate = new Date(currentDate);
    pastDate.setDate(currentDate.getDate() - 7);
 
    var pastDateFormatted = formatDateToDDMMYYYY(pastDate);
 
    if (reqdate < pastDate) {
        alert("Date of Revalidation Request is allowed to select upto 7 days prior sysdate");
        document.forms[0].txt_revalidreqdt.value = "";
        return false;
    }
    return true;
}
function callDisable(one)
{
	debugger
	console.log("callDisable");
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;
		}
		
	}
	
	
}
function callSearch(option)
{
	debugger
	console.log("callSerch");
	if(document.forms[0].cmdsave.disabled == false || document.forms[0].cmdsend.disabled == false)
	{	
		if(option=="A")
			var varQryString = appURL+"action/reval_delegationsearch.jsp?pagefrom=propflow&hidBeanId=commworkflow&hidBeanGetMethod=getrevalidUserSearchData&appno="+document.forms[0].appno.value+"&hidDetails=A&struserID="+struserID;
		else
			var varQryString = appURL+"action/reval_delegationsearch.jsp?appno="+document.forms[0].appno.value+"&hidDetails=S";
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=no";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function comparedate(date1,date2)
{	
	debugger
	console.log("comparedate");
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
	if(pgdt.value!="")
	{
		{
		
			if(Date.parse(pgdt) > Date.parse(maxdt))
			{
				alert("date should not be lesser than appraised  date.");
				document.forms[0].txt_date.value="";
				document.forms[0].txt_date.focus();								
			}	
		}
				
	}
}

</script>
</head>
<body onLoad="onLoading()">
<form name="comments" method="post" class="normal"><lapschoice:application />

<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable linebor" align="center">
	<tr class="dataheader">
	<%if(!strStatus.equalsIgnoreCase("")){ %>
	<td width="10%">Revalidation Status </td>
	<%if(strStatus.equalsIgnoreCase("ps")){ %>
	<td width="10%"><%=strStatus%> &nbsp;&nbsp; to &nbsp;&nbsp; <%=Helper.correctNull((String) hshValues.get("APP_REVALIDATEDBY"))%></td>
	<%}  else{%>
	
	<td width="10%"><%=strStatus%> &nbsp;&nbsp; with &nbsp;&nbsp; <%=Helper.correctNull((String) hshValues.get("APP_REVALIDATEDBY"))%></td>
	<% }%>
	<%}
	if(!Helper.correctNull((String)hshValues.get("APP_REFERENCENO")).equalsIgnoreCase("")){ %>
		<td width="15%">Revalidation Reference Number </td>
		<td width="40%"><%=Helper.correctNull((String)hshValues.get("APP_REFERENCENO")) %></td>
	<% }%> 
	</tr>
</table>
<br>

<table width="98%" border="0" cellpadding="3" cellspacing="0"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0"
			class="outertable border1" align="center">
			<tr>
			<td>Date of Revalidation request received</td>			
			<td><input type="text" name="txt_revalidreqdt"
			value="<%=Helper.correctNull((String)hshValues.get("APP_REVALID_REQ_DT"))%>"
			size="12" onKeyPress="" maxlength="19" onBlur="checkDate(this);checkreqdate();checkmaxdate(this,currentDate);" readonly=true>
			<a href="#"
							onClick="callCalender1('txt_revalidreqdt')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a>
					
			</td>			
				<td>Revalidation Charges</td>				
				<td align="left"><input type="text" name="txt_revalidcharges" value="<%=Helper.correctNull((String)hshValues.get("APP_REVALID_CHARGE"))%>" onKeyPress="allowNumber(this)" maxlength="20" size="20">
				</td>
			</tr>
			</table>
			<table width="93%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td><span class="mantatory">Sanction Validity upto :<%=Helper.correctNull((String)hshValues.get("strSancValidity"))%></span></td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("APP_REVALFLAG")).equalsIgnoreCase("Y") && Helper.correctNull((String)hshValues.get("APP_REVALSTATUS")).equalsIgnoreCase("pa")){ %>
			<tr>
				<td><span class="mantatory">Revalidation Validity upto :<%=Helper.correctNull((String)hshValues.get("strRevalValidity"))%></span></td>
			</tr>
			<%}else{%>
			<tr>
				<td><span class="mantatory">Not Availed/Revalidated Validity upto :<%=Helper.correctNull((String)hshValues.get("strNotAvailedValidity")) %></span></td>
			</tr>
			<%} %>
		</table>
			<%--<td> Reason for Revalidation and Delay in facility availing</td>
			<td><input type="text" name="txt_reasonfordelay" value="<%=Helper.correctNull((String)hshValues.get("APP_DELAYFACILITY"))%>" maxlength="100" size="20"></td>
			</tr>
			<tr>
				<td>Branch Recommendation</td>
				<td><input type="text" name="txt_branchrecomend" value="<%=Helper.correctNull((String)hshValues.get("APP_BRNRECOMMEND"))%>" maxlength="100" size="20"></td>
				 <td>Department comments and recommendation</td>
				<td><input type="text" name="txt_deptrecomend" value="<%=Helper.correctNull((String)hshValues.get("APP_DEPTCOMMENTS"))%>" maxlength="100" size="20"></td>
			 --%>
			 <table width="100%" border="0" cellpadding="3" cellspacing="0"
			class="outertable border1" align="center">
			 <tr class="dataheader"><td>Reason for Revalidation and Delay in facility availing</td></tr>
			<tr>
						<td>
						<div id="id_div6">
						<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("APP_DELAYFACILITY")) %></div>
						</div>
						<div id="id_editor6"><textarea name="txt_reasonfordelay"
							cols="30" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("APP_DELAYFACILITY")) %></textarea></div>
						</td>
			</tr>
			 <tr class="dataheader"><td>Branch Recommendation</td></tr>
			<tr>
						<td>
						<div id="id_div5">
						<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("APP_BRNRECOMMEND")) %></div>
						</div>
						<div id="id_editor5"><textarea name="txt_branchrecomend"
							cols="30" rows="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("APP_BRNRECOMMEND")) %></textarea></div>
						</td>
			</tr>
			<tr class="dataheader"><td>Department comments and recommendation</td></tr>
			<tr>
						<td>
						<div id="id_div4">
						<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("APP_DEPTCOMMENTS")) %></div>
						</div>
						<div id="id_editor4"><textarea name="txt_deptrecomend"
							cols="30" rows="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("APP_DEPTCOMMENTS")) %></textarea></div>
						</td>
			</tr>
			
			</table>
			<%-- <table width="100%" border="0" cellpadding="3" cellspacing="0"
			class="outertable border1" align="center">
			<tr class="dataheader">
						<td>Approving Authority Comments</td>
					</tr>
			<tr>
				<td>
				<div id="id_div3">
				<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("APP_APPROVEAUTH_COMMENTS")) %></div>
				</div>
				<div id="id_editor3"><textarea name="txtarea_comments3"
					cols="30" rows="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("APP_APPROVEAUTH_COMMENTS")) %></textarea></div>
				</td>
			</tr>
		</table> --%>
		<table width="100%" border="0" cellpadding="3" cellspacing="0"
			class="outertable border1" align="center">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="3" cellspacing="0"
					class="outertable" align="center">
					<tr class="dataheader" style="display:none">
						<td>Reason for Revalidation</td>
					</tr>
					<tr style="display:none">
						<td>
						<div id="id_div">
						<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("APP_REVALIDATION_REASON")) %></div>
						</div>
						<div id="id_editor"><textarea name="txtarea_comments"
							cols="30" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("APP_REVALIDATION_REASON")) %></textarea></div>
						</td>
					</tr>

					<tr class="datagrid">
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr id="org">
								<td valign="top">

								<table width="93%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td width="30%" nowrap>Select Organisation</td>
										<td width="60%"><input type="text" name="org_name"
											size="25" readonly="readonly" value="<%=strOrgName%>"><span
											id="idorgselect"> <a href="#"
											onClick="javascript:callOrgHelp()"> <img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"> </a></span></td>
									</tr>
								</table>
								</td>

								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable">
											<tr>

												<td id="deprt1" width="16%">Department<span
													class="mantatory">*&nbsp;</span></td>

												<td id="deprt2" width="15%"><select
													name="usr_department">
													<option value="0">---Select---</option>
													<%String apptypecon = "20";%>
													<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
												</select></td>

												<td width="21%" align="center">Select Recipient</td>

												<td width="48%"><input type="text" name="mail_tousrid"
													size="25" readonly="readonly" value=""> <input
													type="hidden" name="hidmail_tousrid"> <a href="#"
													onClick="javascript:callUsersHelp()"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0"> </a></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr class="dataheader">
						<td>Revalidation Approval Comments</td>
					</tr>
					<tr>
						<td>
						<div id="id_div1">
						<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("APP_SANCTION_CMTS")) %></div>
						</div>
						<div id="id_editor1"><textarea name="txtarea_comments1"
							cols="30" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("APP_SANCTION_CMTS")) %></textarea></div>
						</td>
					</tr>
				</table>
				<!-- changes on 10092024 -->	
		<table width="93%" border="0" cellspacing="0" cellpadding="0" class="outertable">						
		<tr>		
		<td width="15%">Appraised By</td>	
                   <td width="25%" align="center"><input type="text" name="txt_name" size="35"
									maxlength="15"  value="<%=Helper.correctNull((String)hshValues.get("APP_APPRAISED_USERID"))%>" readonly> <span
									onClick="callSearch('A')" style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></span>
									<input type="hidden" name="hidDetails" value="A"></td>
                  <td width="25%" align="center"> 
                    <input type="hidden" name="txt_desig" maxlength="40" size="40" value="<%=Helper.correctNull((String)hshValues.get("APP_APPRAISED_USERDES"))%>" readOnly>
                    <input type="text" name="txt_desig1" maxlength="40" size="40" value="<%=Helper.correctNull((String)hshValues.get("APP_APPRAISED_USERDES_DESC"))%>" readOnly></td>
										<td  width="25%" align="center"><input type="text" name="txt_date"
													size="16" readOnly=true
													onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate(document.forms[0].txt_date.value,document.forms[0].txt_sancdate.value)"
													value="<%=Helper.correctNull((String)hshValues.get("APP_APPRAISED_DATE"))%>">
												<a alt="Select date from calender" 	onClick="callCalender1('txt_date')" id="idtxt_date"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a> 
							</td>
			</tr>
			<tr>
			<td>Sanctioned By</td>	
                   <td width="25%" align="center"><input type="text" name="txt_sancname" size="35"
									maxlength="15"   value="<%=Helper.correctNull((String)hshValues.get("APP_SANC_USERID"))%>" readonly> <span
									onClick="callSearch('S')" style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></span>
									<input type="hidden" name="hidDetails" value="S"></td>
                  <td width="25%" align="center"> 
                    <input type="hidden" name="txt_sancdesig" maxlength="40" size="40"  value="<%=Helper.correctNull((String)hshValues.get("APP_SANC_USERDES"))%>" readOnly>
                    <input type="text" name="txt_sancdesig1" maxlength="40" size="40"  value="<%=Helper.correctNull((String)hshValues.get("APP_SANC_USERDES_DESC"))%>" readOnly></td>
										<td  width="25%" align="center"><input type="text" name="txt_sancdate"
													size="16"
													onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate(document.forms[0].txt_date.value,document.forms[0].txt_sancdate.value)"
													 value="<%=Helper.correctNull((String)hshValues.get("APP_SANC_DATE"))%>">
												<a alt="Select date from calender" 	onClick="callCalender1('txt_sancdate')" id="idtxt_sancdate"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a> 
			</tr>
		</table>
				</td>
			</tr>
		
		
		</table>	
		<lapschoice:combuttonnew
			btnnames='Edit_Save_Approve_Reject_Undo_Send_Send Back To Branch_Cancel' btnenable='N' />
		
		<lapschoice:hiddentag /> <input type="hidden" name="org_code"
			value="<%=strOrgCode%>"> <input type="hidden"
			name="hidFacilitysno"
			value="<%=Helper.correctInt((String)hshValues.get("hidFacilitysno"))%>">
		<input type="hidden" name="mail_touserclass"> <input
			type="hidden" name="hiduserClass">
			<input type="hidden" name="org_level" value="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>">
		
		<input type="hidden" name="hidsanctionvalidupto" value="<%=Helper.correctNull((String)hshValues.get("strNotAvailedValidity"))%>"> 
		<input type="hidden" name="hidappraiseddate" value="">	
		</form>
</td>
</tr>
</table>
</body>
</html>