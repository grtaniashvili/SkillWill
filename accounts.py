import sys
import  json

class CreateAccount:

    def __init__(self, username, password):
        self.username = username
        self.__password = password

        @property
        def password(self):
            return self.__password

        @password.setter
        def password(self, new_password):
            self.__password = new_password

    def add_data(self):
        with open('accounts.json', 'r') as file:
            json_data = json.load(file)
        json_data.append({'username': self.username, 'password': self.__password})
        with open("accounts.json", "w") as outfile:
            json.dump(json_data, outfile, indent=2)

