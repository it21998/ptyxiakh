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

from django_keycloak.models import Nonce
from django.http.response import (
    HttpResponseBadRequest,
    HttpResponseServerError,
    HttpResponseRedirect
)
from django_keycloak.services.oidc_profile import get_remote_user_model
from django_keycloak.auth import remote_user_login


def Home(request):
    if not request.user.is_authenticated:
        try:
            if 'error' in request.GET:
                return HttpResponseServerError(request.GET['error'])

            if 'code' not in request.GET and 'state' not in request.GET:
                flag=1
                return render(request,"home.html",{"flag":flag})

            if 'oidc_state' not in request.session \
                    or request.GET['state'] != request.session['oidc_state']:
                # Missing or incorrect state; login again.
                return HttpResponseRedirect(reverse('keycloak_login'))

            nonce = Nonce.objects.get(state=request.GET['state'])

            user = authenticate(request=request,
                                code=request.GET['code'],
                                redirect_uri=nonce.redirect_uri)

            RemoteUserModel = get_remote_user_model()
            if isinstance(user, RemoteUserModel):
                remote_user_login(request, user)
            else:
                login(request, user)

            nonce.delete()
            
            userrole=role_mapping_function(request)
            return HttpResponseRedirect('http://stratologia-django.cloudns.ph')
        except Exception as e:
            print(e)
            userrole="0"
    else:
        userrole=role_mapping_function(request)
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
    



