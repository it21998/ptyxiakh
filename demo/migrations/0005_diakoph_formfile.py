# Generated by Django 3.2 on 2022-11-06 13:35

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('demo', '0004_auto_20221106_1326'),
    ]

    operations = [
        migrations.AddField(
            model_name='diakoph',
            name='formFile',
            field=models.FileField(default='0000000', upload_to=''),
        ),
    ]