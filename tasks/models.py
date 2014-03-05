from django.db import models
from django.contrib.auth.models import User

class UserProfile(models.Model):
	user = models.ForeignKey(User, unique=True)
	
class Task(models.Model):
	taskText = models.CharField(max_length=1000)
	tasker = models.ForeignKey(User, related_name="tasker")
	taskee = models.ForeignKey(User, related_name="taskee")