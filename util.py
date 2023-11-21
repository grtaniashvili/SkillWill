import json
from diarybook import Diary
from accounts import  CreateAccount


def read_from_json_into_application(path):
    file = open(path)
    data = json.loads(file.read())
    diaries = []
    for entry in data:
        diaries.append(Diary(entry['memo'], entry['tags'], entry['user']))

    return diaries

