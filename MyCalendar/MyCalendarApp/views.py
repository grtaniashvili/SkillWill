from django.http import HttpResponse
from datetime import datetime


def calendar(request):
    return HttpResponse(f'{datetime.now()}')

# Create your views here.
