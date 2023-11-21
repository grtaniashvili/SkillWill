import sys
import  json

from diarybook import Diary, DiaryBook
from util import read_from_json_into_application


class Menu:

    def __init__(self):
        self.diarybook = DiaryBook()
        self.user = ""
        self.choices = {
            "1": self.show_diaries,
            "2": self.add_diary,
            "3": self.search_diaries,
            "4": self.sort_diaries,
            '5': self.quit
        }

    def display_menu(self):
        print(""" 
                     Notebook Menu  
                    1. Show diaries
                    2. Add diary
                    3. Search diaries
                    4. Sort_diaries
                    5. Quit program
                    """)

    def run(self):
        self.populate_database()
        while True:
            self.display_menu()
            choice = input("Enter an option: ")
            action = self.choices.get(choice)
            if action:
                action()
            else:
                print("{0} is not a valid choice".format(choice))

    def runwithuser(self, user):
        self.user = user
        self.run()

    def show_diaries(self, diaries=None):
        if not diaries:
            diaries = self.diarybook.diaries
        for diary in diaries:
            print(f"{diary.id}-{diary.memo}")

    def add_diary(self):
        memo = input("Enter a memo:         ")
        tags = input("add tags:             ")
        self.diarybook.new_diary(memo, tags)
        print("Your note has been added")
        with open('data.json', 'r') as file:
            json_data = json.load(file)
        json_data.append({'memo': memo, 'tags': tags, 'user': self.user})
        with open("data.json", "w") as outfile:
            json.dump(json_data, outfile, indent=2)

    def search_diaries(self):

        filter_text = input("Search for:  ")
        diaries = self.diarybook.search_diary(filter_text)
        for diary in diaries:
            print(f"{diary.id}-{diary.memo}")

    def sort_diaries(self):
        id = input("Enter an Option For Sort From id or memo:   ")
        diares = self.diarybook.diaries
        sorted_diares = []
        if id == 'memo':
            for diary in diares:
                sorted_diares.append(diary.memo)
            sorted_diares.sort()
            for diary1 in sorted_diares:
                print(diary1)
        else:
            for diary in diares:
                print(f"{diary.id}-{diary.memo}")


    def quit(self):

        print("Thank you for using diarybook today")
        sys.exit(0)

    def populate_database(self):
        diaries1 = read_from_json_into_application('data.json')
        for diary in diaries1:
            if diary.user == self.user:
                self.diarybook.diaries.append(diary)


#if __name__ == "__main__":
#    Menu().run()
