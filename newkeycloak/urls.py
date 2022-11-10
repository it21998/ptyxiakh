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

]+static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)+static(settings.STATIC_URL,document_root=settings.STATIC_ROOT)
