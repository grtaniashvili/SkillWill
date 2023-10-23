from abc import ABC, abstractclassmethod

class Person(ABC):
    @property
    @abstractclassmethod
    def display_details(self):
        pass

class Grade_Exception(Exception):
    """
    Grade greater then 10
    """

class Student(Person):
    def __init__(self, student_id, name, grades):
        self._student_id = student_id
        self.name = name
        self.grades = grades

    @property
    def student_id(self):
        return self._student_id
    
    @student_id.setter
    def student_id(self, id):
        print("You Can't chande Student ID")

    def add_grade(self, subject,  grade):
        if self.grades[subject] + grade > 10:
            raise Grade_Exception(f"Grade is more then 10, {self.grades[subject] + grade}")
        else:
            self.grades[subject] += grade 


    @property
    def average_grade(self):
        return round(sum(self.grades.values()) / len(self.grades.values()), 2)
    
    @property
    def display_details(self):
        return f"მოსწავლის ID: {self.student_id}, სახელი: {self.name}, საშ. შეფასება: {self.average_grade}"

class StudentManagementSystem:
    def __init__(self):
        self.students = {}
        self.id = 0 

    def add_student(self,student_id, name, grades):
        if student_id in self.students.keys():
            print(f"Student with ID: {student_id} is already exists")
        else:
            new_student = Student(student_id, name, grades)
            self.students[student_id] = new_student
            self.id = student_id
    @property
    def show_student_details(self):
        print(self.students.get(self.id).display_details)
    @property
    def show_student_avarage_grade(self):
        print(self.students.get(self.id).average_grade) 

student1 = Student(1,"Grigol",{"Math": 4, "Physics": 10, "Geography": 8})
print(student1.grades)
student1.add_grade("Math",1)
print(student1.grades)
print(student1.average_grade)
print(student1.display_details)

student1.student_id = 3
print(student1.display_details)

student2 = StudentManagementSystem()
student3 = StudentManagementSystem()
student2.add_student(2,"fff",{"Math": 4, "Physics": 10, "Geography": 8})
student3.add_student(3,"jjj",{"Math": 5, "Physics": 9, "Geography": 7})

student2.show_student_details
student3.show_student_details
student3.show_student_avarage_grade
