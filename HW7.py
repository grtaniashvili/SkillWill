from abc import ABC, abstractmethod

class Vehicle(ABC):
    @abstractmethod
    def start_engine(self):
        pass

    @abstractmethod
    def stop_engine(self):
        pass


class Car(Vehicle):
    def __init__(self, max_speed, current_speed):
        self.max_speed = max_speed
        self.current_speed = current_speed
    
    def start_engine(self):
        return "car started"

    def stop_engine(self):
        return "car stopped"


class SportCar(Car):
    def __init__(self, max_speed, current_speed):
        super().__init__(max_speed, current_speed)
    
    def start_engine(self):
        
        return f"{super().start_engine()}, Max Speed: {self.max_speed} "

    def stop_engine(self):
        self.current_speed = 0 
        return super().stop_engine()
    


BMW = SportCar(300,79)
print(BMW.current_speed)
print(BMW.start_engine())
print(BMW.stop_engine())
print(BMW.current_speed)