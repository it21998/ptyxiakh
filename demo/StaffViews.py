from contextlib import nullcontext
from django.shortcuts import render
from django.contrib import messages
from django.urls import reverse
from pkg_resources import require
from django.http import HttpResponse, HttpResponseRedirect
from django.core.mail import send_mail

from demo.models import Aithsh, Apografh, Diakoph, Sxolh
from demo.views import role_mapping_function


def staff_home(request):
    if not request.user.is_authenticated:
        return HttpResponseRedirect('http://127.0.0.1:8000')
    userrole=role_mapping_function(request)
    return render(request,"staff_templates/base_template.html",{"userrole":userrole})


def check_applications(request):
        if not request.user.is_authenticated:
          return HttpResponseRedirect('http://127.0.0.1:8000')
        userrole=role_mapping_function(request)
        applications=Aithsh.objects.all()
        return render(request,"staff_templates/staff_manage_applications.html",context={'applications':applications,'userrole':userrole})



def edit_application(request,application_id):
    if not request.user.is_authenticated:
        return HttpResponseRedirect('http://127.0.0.1:8000')
    userrole=role_mapping_function(request)
    applications=Aithsh.objects.get(id=application_id)
    return render(request,"staff_templates/edit_application_template.html",{"applications":applications,"id":application_id,"userrole":userrole})



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

            send_mail(
                'Έλεγχος Αίτησης Στράτευσης ',
                "Ελέγθηκε απο τον υπεύθυνο η αίτηση στράτευσης που κάνατε με ID: "+str(application_id)+". \nΜπορείτε να ελέγξετε την κατάσταση της αίτησης σας στο <Οι αιτήσεις μου>.\nΣε περίπτωση επιβεβαίωσης στης αίτησης μεταβείτε στο <Κατάταξη> \nγια να λάβετε πληροφορίες για την κατάταξη σας! ",
                request.user.email,
                [application.email],
                fail_silently=False,)
            messages.success(request,"Successfully Edited Application")
            return HttpResponseRedirect(reverse("edit_application",kwargs={"application_id":application_id}))
        except:
            messages.error(request,"Failed to Edit Application")
            return HttpResponseRedirect(reverse("edit_application",kwargs={"application_id":application_id}))



def check_anaboles(request):
        if not request.user.is_authenticated:
          return HttpResponseRedirect('http://127.0.0.1:8000')
        userrole=role_mapping_function(request)
        anaboles=Diakoph.objects.all()
        return render(request,"staff_templates/staff_manage_anaboles.html",context={'anaboles':anaboles,'userrole':userrole})



def edit_anabolh(request,anabolh_id):
    if not request.user.is_authenticated:
        return HttpResponseRedirect('http://127.0.0.1:8000')
    userrole=role_mapping_function(request)
    anaboles=Diakoph.objects.get(id=anabolh_id)
    return render(request,"staff_templates/edit_anabolh_template.html",{"anaboles":anaboles,"id":anabolh_id,"userrole":userrole})



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
              
            send_mail(
                'Έλεγχος Αναβολής ',
                "Ελέγθηκε απο τον υπεύθυνο η αίτηση αναβολής που κάνατε με ID: "+str(anabolh_id)+". \nΜπορείτε να ελέγξετε την κατάσταση της αίτησης αναβολής σας στο <Οι αιτήσεις μου> ",
                request.user.email,
                [anabolh.email],
                fail_silently=False,)

            messages.success(request,"Successfully Edited Application")
            return HttpResponseRedirect(reverse("edit_anabolh",kwargs={"anabolh_id":anabolh_id}))
        except:
            messages.error(request,"Failed to Edit Application")
            return HttpResponseRedirect(reverse("edit_anabolh",kwargs={"anabolh_id":anabolh_id}))



def check_apografes(request):
    if not request.user.is_authenticated:
        return HttpResponseRedirect('http://127.0.0.1:8000')
    userrole=role_mapping_function(request)
    apografes=Apografh.objects.all()
    return render(request,"staff_templates/staff_manage_apografes.html",context={'apografes':apografes,'userrole':userrole})



def edit_apografh(request,apografh_id):
    if not request.user.is_authenticated:
        return HttpResponseRedirect('http://127.0.0.1:8000')
    userrole=role_mapping_function(request)
    apografes=Apografh.objects.get(id=apografh_id)
    return render(request,"staff_templates/edit_apografh_template.html",{"apografes":apografes,"id":apografh_id,"userrole":userrole})


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
            send_mail(
                'Έλεγχος Απογραφής ',
                "Ελέγθηκε απο τον υπεύθυνο η αίτηση απογραφής που κάνατε με ID: "+str(apografh_id)+". \nΜπορείτε να ελέγξετε την κατάσταση της απογραφής σας στο <Οι αιτήσεις μου> ",
                request.user.email,
                [apografh.email],
                fail_silently=False,)
        
            messages.success(request,"Successfully Edited Application")
            return HttpResponseRedirect(reverse("edit_apografh",kwargs={"apografh_id":apografh_id}))
        except:
            messages.error(request,"Failed to Edit Application")
            return HttpResponseRedirect(reverse("edit_apografh",kwargs={"apografh_id":apografh_id}))




def check_sxoles(request):
        if not request.user.is_authenticated:
          return HttpResponseRedirect('http://127.0.0.1:8000')
        userrole=role_mapping_function(request)
        sxoles=Sxolh.objects.all()
        return render(request,"staff_templates/staff_manage_sxoles.html",context={'sxoles':sxoles,'userrole':userrole})



def edit_sxolh(request,sxolh_id):
    if not request.user.is_authenticated:
        return HttpResponseRedirect('http://127.0.0.1:8000')
    userrole=role_mapping_function(request)
    sxoles=Sxolh.objects.get(id=sxolh_id)
    return render(request,"staff_templates/edit_sxolh_template.html",{"sxoles":sxoles,"id":sxolh_id,"userrole":userrole})



def edit_sxolh_save(request):
    if request.method!="POST":
        return HttpResponse("<h2>Method Not Allowed</h2>")
    else:
        sxolh_id=request.POST.get("sxolh_id")
        try:
            sxolh=Sxolh.objects.get(id=sxolh_id)
            sxolh.status=request.POST.get("status")
            sxolh.save()

            send_mail(
                'Έλεγχος Εγγραφής Σχολής ',
                "Ελέγθηκε απο τον υπεύθυνο η αίτηση εγγραφής στη στρατιωτική σχολή: "+str(sxolh.mysxolh)+" που κάνατε με ID: "+str(sxolh_id)+". \nΜπορείτε να ελέγξετε την κατάσταση της αίτησης σας στο <Οι αιτήσεις μου> ",
                request.user.email,
                [sxolh.email],
                fail_silently=False,)
            messages.success(request,"Successfully Edited Application")
            return HttpResponseRedirect(reverse("edit_sxolh",kwargs={"sxolh_id":sxolh_id}))
        except:
            messages.error(request,"Failed to Edit Application")
            return HttpResponseRedirect(reverse("edit_sxolh",kwargs={"sxolh_id":sxolh_id}))

