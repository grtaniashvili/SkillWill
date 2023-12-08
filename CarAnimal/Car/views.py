from rest_framework import response
from rest_framework.response import Response

from .models import Car
from rest_framework.views import APIView
from .serializer import CarSerializer


class CarListView(APIView):
    def get(self, request):
        cars = Car.objects.all()
        serializer = CarSerializer(cars, context={'request': request}, many=True)
        return Response(serializer.data)


class AddCarView(APIView):
    def post(self, request):
        serializer = CarSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return response.Response(serializer.errors, status=400)
