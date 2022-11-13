from django.db import models

# Create your models here.



class Aithsh(models.Model):
    id=models.AutoField(primary_key=True)
    first_name=models.CharField(max_length=255)
    last_name=models.CharField(max_length=255)
    email=models.CharField(max_length=255)
    age=models.CharField(max_length=255)
    formFile = models.FileField(default='0000000')
    katatajh=models.CharField(max_length=255)
    education_level=models.CharField(max_length=255)
    communication=models.CharField(max_length=255)
    status=models.CharField(max_length=255)
    nomos_stratopedou=models.CharField(max_length=255)
    number_stratopedou=models.CharField(max_length=255)
    military_id=models.CharField(max_length=255)
    created_at=models.DateTimeField(auto_now_add=True)
    updated_at=models.DateTimeField(auto_now_add=True)
    objects=models.Manager()

class Diakoph(models.Model):
    id=models.AutoField(primary_key=True)
    first_name=models.CharField(max_length=255)
    last_name=models.CharField(max_length=255)
    email=models.CharField(max_length=255)
    aithsh_id=models.CharField(max_length=255)
    reason=models.CharField(max_length=355)
    formFile = models.FileField(default='0000000')
    status=models.CharField(max_length=255)
    created_at=models.DateTimeField(auto_now_add=True)
    updated_at=models.DateTimeField(auto_now_add=True)
    objects=models.Manager()    

class Apografh(models.Model):
    id=models.AutoField(primary_key=True)
    first_name=models.CharField(max_length=255)
    last_name=models.CharField(max_length=255)
    email=models.CharField(max_length=255)
    father_name=models.CharField(max_length=255)
    mother_name=models.CharField(max_length=255)
    id_number=models.CharField(max_length=255)
    AFM=models.CharField(max_length=255)
    nomos=models.CharField(max_length=255)
    perioxh=models.CharField(max_length=255)
    odos=models.CharField(max_length=255)
    aithsh_id=models.CharField(max_length=255)
    height=models.CharField(max_length=255)
    weight=models.CharField(max_length=255)
    katatajh=models.CharField(max_length=255)
    education_level=models.CharField(max_length=255)
    communication=models.CharField(max_length=255)
    formFile = models.FileField(default='0000000')
    status=models.CharField(max_length=255)
    created_at=models.DateTimeField(auto_now_add=True)
    updated_at=models.DateTimeField(auto_now_add=True)
    objects=models.Manager()      

class Sxolh(models.Model):
    id=models.AutoField(primary_key=True)
    first_name=models.CharField(max_length=255)
    last_name=models.CharField(max_length=255)
    email=models.CharField(max_length=255)
    age=models.CharField(max_length=255)
    AFM=models.CharField(max_length=255)
    AMKA=models.CharField(max_length=255)
    communication=models.CharField(max_length=255)
    mysxolh=models.CharField(max_length=255)
    formFile = models.FileField(default='0000000')
    status=models.CharField(max_length=255)
    created_at=models.DateTimeField(auto_now_add=True)
    updated_at=models.DateTimeField(auto_now_add=True)
    objects=models.Manager()



class MyRoles(models.Model):
    id=models.AutoField(primary_key=True)
    useremail=models.CharField(max_length=255)
    userrole=models.CharField(max_length=255)
    created_at=models.DateTimeField(auto_now_add=True)
    updated_at=models.DateTimeField(auto_now_add=True)
    objects=models.Manager()        