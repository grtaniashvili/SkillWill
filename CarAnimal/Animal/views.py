from rest_framework.response import Response

from Animal.models import Animal
from rest_framework.views import APIView
from .serializer import AnimalSerializer


class AnimalListView(APIView):
    def get(self, request):
        animals = Animal.objects.all()
        serializer = AnimalSerializer(animals, context={'request': request}, many=True)
        return Response(serializer.data)

class AddAnimalView(APIView):
    def post(self, request):
        serializer = AnimalSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors)


class DeleteAnimalView(APIView):
    def delete(self, request, pk):
        animal = Animal.objects.get(pk=pk)
        animal.delete()
        return Response("Deleted!...")


class UpdateAnimalView(APIView):
    def put(self, request, pk):
        animal = Animal.objects.get(pk=pk)
        serializer = AnimalSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors)