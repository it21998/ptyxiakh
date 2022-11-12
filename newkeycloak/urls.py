"""newkeycloak URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from demo.views import Home # new
from django.contrib import admin
from django.urls import path
from newkeycloak import settings
from django.conf.urls.static import static
from demo import SoldierViews, StaffViews, views


urlpatterns = [
    path('admin/', admin.site.urls),
    path('keycloak/', include('django_keycloak.urls')),
    path('', Home.as_view(), name='home'),
    path('get_user_details', views.GetUserDetails),
    path('logout_user', views.logout_user,name="logout"),
    path('soldier_home', SoldierViews.soldier_home, name="soldier_home"),
    path('add_application', SoldierViews.add_application, name='add_application'),
    path('add_application_save',SoldierViews.add_application_save,name="add_application_save"),
    path('add_diakoph', SoldierViews.add_diakoph, name='add_diakoph'),
    path('add_diakoph_save',SoldierViews.add_diakoph_save,name="add_diakoph_save"),
    path('add_apografi', SoldierViews.add_apografi, name='add_apografi'),
    path('add_apografi_save',SoldierViews.add_apografi_save,name="add_apografi_save"),
    path('add_sxolh', SoldierViews.add_sxolh, name='add_sxolh'),
    path('add_sxolh_save', SoldierViews.add_sxolh_save, name='add_sxolh_save'),
    path('check_katatajh', SoldierViews.check_katatajh, name='check_katatajh'),
    path('check_myaithseis', SoldierViews.check_myaithseis, name='check_myaithseis'),
    path('staff_home', StaffViews.staff_home, name="staff_home"),
    path('check_applications', StaffViews.check_applications, name="check_applications"),
    path('edit_application/<str:application_id>', StaffViews.edit_application,name="edit_application"),
    path('edit_application_save', StaffViews.edit_application_save,name="edit_application_save"),
    path('check_anaboles', StaffViews.check_anaboles, name="check_anaboles"),
    path('edit_anabolh/<str:anabolh_id>', StaffViews.edit_anabolh,name="edit_anabolh"),
    path('edit_anabolh_save', StaffViews.edit_anabolh_save,name="edit_anabolh_save"),
    path('check_apografes', StaffViews.check_apografes, name="check_apografes"),
    path('edit_apografh/<str:apografh_id>', StaffViews.edit_apografh,name="edit_apografh"),
    path('edit_apografh_save', StaffViews.edit_apografh_save,name="edit_apografh_save"),
    path('check_sxoles', StaffViews.check_sxoles, name="check_sxoles"),
    path('edit_sxolh/<str:sxolh_id>', StaffViews.edit_sxolh,name="edit_sxolh"),
    path('edit_sxolh_save', StaffViews.edit_sxolh_save,name="edit_sxolh_save"),
]+static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)+static(settings.STATIC_URL,document_root=settings.STATIC_ROOT)
