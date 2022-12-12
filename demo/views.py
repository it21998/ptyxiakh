import this
from django.shortcuts import render


# Create your views here.
from django.shortcuts import render
from django.views.generic import TemplateView
from django.shortcuts import render
from django.contrib.auth import authenticate, login, logout
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse
from django.contrib import messages
from demo.models import MyRoles


def Home(request):
    try:
        userrole=role_mapping_function(request)
    except Exception as e:
        print(e)
        userrole="0"
    return render(request,"home.html",{"userrole":userrole})



def role_mapping_function(request):
    flaguser=None
    

    try:
        flaguser=MyRoles.objects.get(useremail=request.user.email)
        print(flaguser.userrole)
        if flaguser.userrole == "soldier" or flaguser.userrole == "staff" or flaguser.userrole == "admin" :
            return flaguser.userrole
    except :        
        try:
         admin_possible=str(request.user.oidc_profile.realm.client.openid_api_client.userinfo(
         token=request.user.oidc_profile.access_token)['admin-attribute'])
         if(admin_possible):
            useremail=request.user.email
            userrole="admin"
            newrole=MyRoles(useremail=useremail,userrole=userrole)
            newrole.save()
            return userrole
        except Exception as e:
            print(e) 


        role_dict=str(request.user.oidc_profile.realm.client.openid_api_client.userinfo(
            token=request.user.oidc_profile.access_token)['role'])

       
        if(role_dict[1:][:7]=="soldier"):   
            useremail=request.user.email
            userrole="soldier"
            newrole=MyRoles(useremail=useremail,userrole=userrole)
            newrole.save()
            return userrole
        elif(role_dict.find("staff")):
            useremail=request.user.email
            userrole="staff"
            newrole=MyRoles(useremail=useremail,userrole=userrole)
            newrole.save()    
            return userrole



def GetUserDetails(request):
    if request.user.is_authenticated:
        role_mapping_function(request)
        return HttpResponse("User : "+str(request.user.oidc_profile.realm.client.openid_api_client.userinfo(
            token=request.user.oidc_profile.access_token)))
    else:
        return HttpResponse("Please Login First")

#User : {'email_verified': False, 'Groups': ['/soldiers'], 'name': 'rey mysterio', 'preferred_username': 'reymysterio', 'given_name': 'rey', 'family_name':
#  'mysterio', 'email': 'rey@hua.gr', 'id': '8f929050-717a-4b78-b0e7-928632fa12ed'}



def logout_user(request):
    logout(request)
    return HttpResponseRedirect('http://stratologia-django.cloudns.ph/keycloak/login')
    



