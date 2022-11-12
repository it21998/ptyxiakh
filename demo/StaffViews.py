from contextlib import nullcontext
from django.shortcuts import render
from django.contrib import messages
from django.urls import reverse
from pkg_resources import require
from django.http import HttpResponse, HttpResponseRedirect
from django.core.mail import send_mail

from demo.models import Aithsh, Apografh, Diakoph, Sxolh


def staff_home(request):
    return render(request,"staff_templates/base_template.html")


def check_applications(request):
        applications=Aithsh.objects.filter(status="pending")
        return render(request,"staff_templates/staff_manage_applications.html",{"applications":applications})



def edit_application(request,application_id):
    applications=Aithsh.objects.get(id=application_id)
    return render(request,"staff_templates/edit_application_template.html",{"applications":applications,"id":application_id})



def edit_application_save(request):
    if request.method!="POST":
        return HttpResponse("<h2>Method Not Allowed</h2>")
    else:
        application_id=request.POST.get("application_id")
        try:
            application=Aithsh.objects.get(id=application_id)
            application.status=request.POST.get("status")
            application.nomos_stratopedou=request.POST.get("nomos_stratopedou")
            application.number_stratopedou=request.POST.get("number_stratopedou")
            application.military_id=request.POST.get("military_id")
            application.save()
            
            messages.success(request,"Successfully Edited Application")
            return HttpResponseRedirect(reverse("edit_application",kwargs={"application_id":application_id}))
        except:
            messages.error(request,"Failed to Edit Application")
            return HttpResponseRedirect(reverse("edit_application",kwargs={"application_id":application_id}))



def check_anaboles(request):
        anaboles=Diakoph.objects.filter(status="pending")
        return render(request,"staff_templates/staff_manage_anaboles.html",{"anaboles":anaboles})



def edit_anabolh(request,anabolh_id):
    anaboles=Diakoph.objects.get(id=anabolh_id)
    return render(request,"staff_templates/edit_anabolh_template.html",{"anaboles":anaboles,"id":anabolh_id})



def edit_anabolh_save(request):
    if request.method!="POST":
        return HttpResponse("<h2>Method Not Allowed</h2>")
    else:
        application_id=request.POST.get("aithsh_id")
        anabolh_id=request.POST.get("anabolh_id")
        try:
            
            anabolh=Diakoph.objects.get(id=anabolh_id)
            anabolh.status=request.POST.get("status")
            anabolh.save()
            if(request.POST.get("status")=="Pass"):
                application=Aithsh.objects.get(id=application_id)
                application.status="Reject"
                application.save()
            

            messages.success(request,"Successfully Edited Application")
            return HttpResponseRedirect(reverse("edit_anabolh",kwargs={"anabolh_id":anabolh_id}))
        except:
            messages.error(request,"Failed to Edit Application")
            return HttpResponseRedirect(reverse("edit_anabolh",kwargs={"anabolh_id":anabolh_id}))



def check_apografes(request):
        apografes=Apografh.objects.all()
        return render(request,"staff_templates/staff_manage_apografes.html",{"apografes":apografes})



def edit_apografh(request,apografh_id):
    apografes=Apografh.objects.get(id=apografh_id)
    return render(request,"staff_templates/edit_apografh_template.html",{"apografes":apografes,"id":apografh_id})


def edit_apografh_save(request):
    if request.method!="POST":
        return HttpResponse("<h2>Method Not Allowed</h2>")
    else:
        apografh_id=request.POST.get("apografh_id")
        try:
            
            apografh=Apografh.objects.get(id=apografh_id)
            if(request.POST.get("status")=="Checked"):
                apografh.status=request.POST.get("status")
            else :
                apografh.status="Unchecked"
            
            
            apografh.save()
            
        
            messages.success(request,"Successfully Edited Application")
            return HttpResponseRedirect(reverse("edit_apografh",kwargs={"apografh_id":apografh_id}))
        except:
            messages.error(request,"Failed to Edit Application")
            return HttpResponseRedirect(reverse("edit_apografh",kwargs={"apografh_id":apografh_id}))




def check_sxoles(request):
        sxoles=Sxolh.objects.filter(status="pending")
        return render(request,"staff_templates/staff_manage_sxoles.html",{"sxoles":sxoles})



def edit_sxolh(request,sxolh_id):
    sxoles=Sxolh.objects.get(id=sxolh_id)
    return render(request,"staff_templates/edit_sxolh_template.html",{"sxoles":sxoles,"id":sxolh_id})



def edit_sxolh_save(request):
    if request.method!="POST":
        return HttpResponse("<h2>Method Not Allowed</h2>")
    else:
        sxolh_id=request.POST.get("sxolh_id")
        try:
            sxolh=Sxolh.objects.get(id=sxolh_id)
            sxolh.status=request.POST.get("status")
            sxolh.save()
            
            messages.success(request,"Successfully Edited Application")
            return HttpResponseRedirect(reverse("edit_sxolh",kwargs={"sxolh_id":sxolh_id}))
        except:
            messages.error(request,"Failed to Edit Application")
            return HttpResponseRedirect(reverse("edit_sxolh",kwargs={"sxolh_id":sxolh_id}))

