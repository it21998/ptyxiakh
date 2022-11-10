import this
from django.shortcuts import render

from django.contrib.auth.mixins import (
    LoginRequiredMixin,
    PermissionRequiredMixin
)
# Create your views here.
from django.shortcuts import render
from django.views.generic import TemplateView
from django.shortcuts import render
from django.contrib.auth import authenticate, login, logout
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from django.urls import reverse
from django.contrib import messages
import requests

class Home(TemplateView):
    template_name = 'home.html'

def GetUserDetails(request):
    if request.user.is_authenticated:
        return HttpResponse("User : "+str(request.user.last_name))
    else:
        return HttpResponse("Please Login First")

#User : {'email_verified': False, 'Groups': ['/soldiers'], 'name': 'rey mysterio', 'preferred_username': 'reymysterio', 'given_name': 'rey', 'family_name':
#  'mysterio', 'email': 'rey@hua.gr', 'id': '8f929050-717a-4b78-b0e7-928632fa12ed'}



def logout_user(request):
    logout(request)
    return HttpResponseRedirect('http://127.0.0.1:8000/keycloak/login')
    



