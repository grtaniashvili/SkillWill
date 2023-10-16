class Heart:
    
    def state(self,usage):
        if usage > 70:
            return "high blood pressure"
        return "feeling good"

class Brain:

    def state(self,usage):
        if usage > 90:
            return "tired"
        return "rested"

class Leg:
    
    def __init__(self, moving_speed):
        self.moving_speed = moving_speed

    def speed(self):
        if self.moving_speed == 0:
           return "standing"
        elif self.moving_speed > 0 and self.moving_speed <= 10:
           return "walking"
        elif self.moving_speed > 10:
           return "running"
        return f"moving speed = {self.moving_speed} and it can't be a negative!!!"   
           
class Person:
    def __init__(self,moving_speed):
        self.brain = Brain()
        self.heart = Heart()
        self.moving_speed = moving_speed


Moving_Speed1 = Leg(17)
Pressure = 79
person1 = Person(Moving_Speed1)

print(person1.moving_speed.speed())
print(person1.brain.state(Pressure))
print(person1.heart.state(Pressure))
