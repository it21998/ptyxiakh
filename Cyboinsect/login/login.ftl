<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
<#if section = "title">
${msg("loginTitle",(realm.displayName!''))}
<#elseif section = "header">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
<script></script>
<#elseif section = "form">
<div class="card card-3">
<div class="card-heading" style="background: url('https://www.rollingstone.com/wp-content/uploads/2022/10/us-socafrica-2022.03.10.niger_.08824.jpg?w=1581&h=1054&crop=1') top left/cover no-repeat;"></div>
<#if realm.password>
<div class="card-body">
<div style="text-align:center;">
   <img  src="https://images.vexels.com/media/users/3/194978/isolated/lists/4e5f08e2a984b379c5d0d7ba1b77489a-general-major-military-rank-icon.png" alt="logo" style="height:60px;">
</div>
<h2 class="title" style="text-align:center;color: black;">Login</h2>
<form id="kc-form-login" class="form form1" return true;" action="${url.loginAction}" method="post">



   <div class="${properties.kcFormGroupClass!}">
                    <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                    <#if usernameEditDisabled??>
                        <input tabindex="1" id="username" class="input--style-3 input-width" placeholder="Username or Email"  name="username" value="${(login.username!'')}" type="text" disabled />
                    <#else>
                        <input tabindex="1" id="username" class="input--style-3 input-width" placeholder="Username or Email"  name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off" />
                    </#if>
                </div>
  






 <div class="input-group">
      <label>Password</label>
      <div>
         <input class="input--style-3 input-width" id="txtPassword" type="password" placeholder="Password" name="password">                       
      </div>
   </div>
   <#if realm.rememberMe && !usernameEditDisabled??>
   <div class="checkbox">
      <label>
      <#if login.rememberMe??>
      <input id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
      <#else>
      <input id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
      </#if>
      </label>
   </div>
   <div style="float: right; margin-top: -25px">
      <#if realm.resetPasswordAllowed>
      <span><a style="color:#e6186d;"  href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
      </#if>  
   </div>
   </#if>  
   <div class="p-t-20 p-b-20" style="text-align:center;color:rgb(20, 179, 152);">
      <button class="submit" value="${msg('doLogIn')}" type="submit">Submit</button>
   </div>
</form>
</#if>
<#if social.providers??>
<div id="social-providers" style="text-align:center;">
   <p><span style="text-align:center;"> or Login With </span></p>
</div>
<#list social.providers as p>
<div style="display: flex; margin-left:20px;">
   <input class="${p.displayName}" 
      style="margin-left:10;margin-right: 10"
      type="button" onclick="location.href='${p.loginUrl}';" value="${p.displayName}"/>
   </#list>
</div>
</#if>
<div style="margin-top:50px;text-align:center">
   <span style="text-size:16px;">Don't have an account?</span>
   <a href="${url.registrationUrl}" style="color:#e6186d;">Signup</a>
   <div>
   </div>
</div>
</#if>
</@layout.registrationLayout>
