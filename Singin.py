from accounts import CreateAccount
from accountcheck import check_account, check_account_password, update_account_password
from  menu import Menu
class Sing_in:
    def __init__(self):
        self.choices = {
                "1": self.create_account,
                "2": self.sing_in,
                "3": self.change_password
            }
    def display_menu(self):

        print(""" 
                     Register/Sing In 
                    1. Create Account
                    2. Sing In
                    3. Change Password
                    """)
    def create_account(self):
        username = input("Username:   ")
        password = input("Password:   ")
        if check_account(username):
            print("Account Is Already exists, Please Sing In!...")
        else:
            new_account = CreateAccount(username, password)
            new_account.add_data()
            print("Account Succesfully Registered!...")
            Menu().runwithuser(username)

    def sing_in(self):
        username = input("Username:   ")
        password = input("Password:   ")
        if check_account(username):
            if check_account_password(username, password):
                print("Singed in succesfully!...")
                Menu().runwithuser(username)
            else:
                print("Password is incorrect!!!")
        else:
            print("Account not exists, Please Register!...")

    def change_password(self):
        username = input("Username:   ")
        psw = input("New Password:    ")
        if update_account_password(username, psw):
            print("You Changed Password: ")
            Menu().runwithuser(username)
        else:
            print("Username is incorrect!")

    def run(self):
        while True:
            self.display_menu()
            choice = input("Enter an option: ")
            action = self.choices.get(choice)
            if action:
                action()
            else:
                print("{0} is not a valid choice".format(choice))

if __name__ == "__main__":
    Sing_in().run()
