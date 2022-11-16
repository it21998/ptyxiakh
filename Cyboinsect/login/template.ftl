<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="https://images.vexels.com/media/users/3/194978/isolated/lists/4e5f08e2a984b379c5d0d7ba1b77489a-general-major-military-rank-icon.png" type="image/x-icon">
 
 <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    

    <title><#nested "title"></title>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
</head>

	<body>
        <#--  <#nested "header">  -->
         <div class="page-wrapper bg-gra-01 p-t-100">
        <div class="wrapper wrapper--w780">
        <#if displayMessage && message?has_content>
        <div class="alert alert-${message.type}">
             <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
             <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
             <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
             <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
            
        </div>
        </#if>
        <#nested "form">

<#if displayMessage && message?has_content>
        <div class="alert alert-${message.type}">
             <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
             <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
             <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
             <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
	
<p align=justify style="background-color:#C70039;
border-radius: 5px;
color: white;
font-family: verdana, 'open sans', sans-serif;
margin-top: 15px;
padding: 10px 14px 10px 44px;
position: relative;
box-shadow: 0px 1px 5px #999;"><b>
${message.summary?no_esc}</b>
</p>


        </div>
        </#if>











            </div> 
        </div>
	</body>
</html>
</#macro>
