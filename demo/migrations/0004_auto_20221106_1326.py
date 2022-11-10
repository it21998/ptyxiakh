# Generated by Django 3.2 on 2022-11-06 13:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('demo', '0003_aithsh_age'),
    ]

    operations = [
        migrations.CreateModel(
            name='Diakoph',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('first_name', models.CharField(max_length=255)),
                ('last_name', models.CharField(max_length=255)),
                ('email', models.CharField(max_length=255)),
                ('aithsh_id', models.CharField(max_length=255)),
                ('reason', models.CharField(max_length=355)),
                ('status', models.CharField(max_length=255)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.AddField(
            model_name='aithsh',
            name='formFile',
            field=models.FileField(default='0000000', upload_to=''),
        ),
    ]
