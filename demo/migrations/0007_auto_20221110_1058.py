# Generated by Django 3.2 on 2022-11-10 10:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('demo', '0006_apografh'),
    ]

    operations = [
        migrations.CreateModel(
            name='Sxolh',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('first_name', models.CharField(max_length=255)),
                ('last_name', models.CharField(max_length=255)),
                ('email', models.CharField(max_length=255)),
                ('age', models.CharField(max_length=255)),
                ('AFM', models.CharField(max_length=255)),
                ('AMKA', models.CharField(max_length=255)),
                ('communication', models.CharField(max_length=255)),
                ('mysxolh', models.CharField(max_length=255)),
                ('formFile', models.FileField(default='0000000', upload_to='')),
                ('status', models.CharField(max_length=255)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.AddField(
            model_name='aithsh',
            name='military_id',
            field=models.CharField(default=0, max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='aithsh',
            name='nomos_stratopedou',
            field=models.CharField(default=0, max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='aithsh',
            name='number_stratopedou',
            field=models.CharField(default=0, max_length=255),
            preserve_default=False,
        ),
    ]