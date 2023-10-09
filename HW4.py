class Student:
    university = ["TSU","GTU","Alte"]

    def __init__(self,name,grade,age):
        self.name = name
        self.grade = grade
        self.age = age

    def is_passing(self):
        if self.grade > 60:
            return True
        return False

    def increase_grade(self,add_grade):
        if isinstance(add_grade,int):
            self.grade += add_grade
            print(f"grade increased with {add_grade} points")
        else:
            print("parameter is not int type")

    def __str__(self):
        return f"Name: {self.name}, Age: {self.age}, Grade: {self.grade}"


student1 = Student("Grigol",56,30)

print(student1)
print(student1.is_passing())
student1.increase_grade("r")
student1.increase_grade(30)
print(student1)
print(student1.is_passing())