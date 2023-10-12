
class Person:
    def __init__(self,name,surname,age):
        self.name = name
        self.surname = surname
        self.age = age

class Str_Mixin:
    def __str__(self):
        return f"Name: [{self.name}, Surname: [{self.surname}], Age: [{self.age}]]"

class Student(Person,Str_Mixin):
    def __init__(self, name, surname, age, university):
        self.university = university
        super().__init__(name, surname, age)




stud1 = Student("Grigol","Taniashvili",30,"Tsu")
print(stud1.age)
print(stud1)