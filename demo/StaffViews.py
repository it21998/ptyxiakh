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


def add_application(request):
        return render(request,"soldier_templates/soldier_add_application_template.html")



def add_application_save(request):
    if request.method!="POST":
        print(request.method)
        return HttpResponse("Method Not Allowed")
    else:
        first_name=request.POST.get("first_name")
        last_name=request.POST.get("last_name")
        email=request.POST.get("email")
        age=request.POST.get("age")
        formFile=request.FILES["formFile"]
        katatajh=request.POST.get("katatajh")
        education_level=request.POST.get("education_level")
        communication=request.POST.get("communication")
        status="pending"
        nomos_stratopedou=0
        number_stratopedou=0
        military_id=0
        try:
            application=Aithsh(first_name=first_name,last_name=last_name,email=email,age=age,formFile=formFile,katatajh=katatajh,education_level=education_level,communication=communication,status=status,nomos_stratopedou=nomos_stratopedou,number_stratopedou=number_stratopedou,military_id=military_id)
            application.save()
          
            messages.success(request,"Successfully Added Application")
            return HttpResponseRedirect(reverse("add_application"))
        except Exception as e:
            print(e)
            messages.error(request,"Failed to Add Application")
            return HttpResponseRedirect(reverse("add_application"))
            


            
def add_diakoph(request):
    
    applications=Aithsh.objects.all()
    return render(request,"soldier_templates/soldier_add_diakoph_template.html",{"applications":applications})





def add_diakoph_save(request):
    if request.method!="POST":
        print(request.method)
        return HttpResponse("Method Not Allowed")
    else:
        first_name=request.POST.get("first_name")
        last_name=request.POST.get("last_name")
        email=request.POST.get("email")
        aithsh_id=request.POST.get("aithsh_id")
        reason=request.POST.get("reason")
        formFile=request.FILES["formFile"]
        status="pending"
       
      
        try:
            diakoph=Diakoph(first_name=first_name,last_name=last_name,email=email,aithsh_id=aithsh_id,reason=reason,formFile=formFile,status=status)
            diakoph.save()
          
            messages.success(request,"Successfully Added Anavolh")
            return HttpResponseRedirect(reverse("add_diakoph"))
        except Exception as e:
            print(e)
            messages.error(request,"Failed to Add Anavolh")
            return HttpResponseRedirect(reverse("add_diakoph"))



def add_apografi(request):
    applications=Aithsh.objects.all()
    return render(request,"soldier_templates/soldier_add_apografi_template.html",{"applications":applications})



def add_apografi_save(request):
    if request.method!="POST":
        print(request.method)
        return HttpResponse("Method Not Allowed")
    else:
        first_name=request.POST.get("first_name")
        last_name=request.POST.get("last_name")
        email=request.POST.get("email")
        father_name=request.POST.get("father_name")
        mother_name=request.POST.get("mother_name")
        id_number=request.POST.get("id_number")
        AFM=request.POST.get("AFM")
        nomos=request.POST.get("nomos")
        perioxh=request.POST.get("perioxh")
        odos=request.POST.get("odos")
        aithsh_id=request.POST.get("aithsh_id")
        height=request.POST.get("height")
        weight=request.POST.get("weight")
        katatajh=request.POST.get("katatajh")
        education_level=request.POST.get("education_level")
        communication=request.POST.get("communication")
        formFile=request.FILES["formFile"]
        
      
        try:
            apografi=Apografh(first_name=first_name,last_name=last_name,email=email,father_name=father_name,mother_name=mother_name,id_number=id_number,AFM=AFM,nomos=nomos,perioxh=perioxh,odos=odos,aithsh_id=aithsh_id,height=height,weight=weight,katatajh=katatajh,education_level=education_level,communication=communication,formFile=formFile)
            apografi.save()
          
            messages.success(request,"Successfully Added Apografi")
            return HttpResponseRedirect(reverse("add_apografi"))
        except Exception as e:
            print(e)
            messages.error(request,"Failed to Add Apografi")
            return HttpResponseRedirect(reverse("add_apografi"))





def add_sxolh(request):
        return render(request,"soldier_templates/soldier_add_sxolh_template.html")




def add_sxolh_save(request):
    if request.method!="POST":
        print(request.method)
        return HttpResponse("Method Not Allowed")
    else:
        first_name=request.POST.get("first_name")
        last_name=request.POST.get("last_name")
        email=request.POST.get("email")
        age=request.POST.get("age")
        AFM=request.POST.get("AFM")
        AMKA=request.POST.get("AMKA")
        communication=request.POST.get("communication")
        mysxolh=request.POST.get("mysxolh")
        formFile=request.FILES["formFile"]
        status="pending"
   
        
        try:
            sxolh=Sxolh(first_name=first_name,last_name=last_name,email=email,age=age,AFM=AFM,AMKA=AMKA,communication=communication,mysxolh=mysxolh,formFile=formFile,status=status)
            sxolh.save()
          
            messages.success(request,"Successfully Added Application")
            return HttpResponseRedirect(reverse("add_sxolh"))
        except Exception as e:
            print(e)
            messages.error(request,"Failed to Add Application")
            return HttpResponseRedirect(reverse("add_sxolh"))


def check_katatajh(request):
        applications=Aithsh.objects.all()
        return render(request,"soldier_templates/soldier_katatajh_template.html",{"applications":applications})



def check_myaithseis(request):
        applications=Aithsh.objects.all()
        anaboles=Diakoph.objects.all()
        sxoles=Sxolh.objects.all()
        return render(request,"soldier_templates/soldier_manage_applications_template.html",context={'applications':applications,'anaboles':anaboles,'sxoles':sxoles})
