import json

def check_account(user):
    with open('accounts.json', 'r') as file:
        json_data = json.load(file)
    for username in json_data:
        if username["username"] == user:
            return True
    return False


def check_account_password(user, psw):
    with open('accounts.json', 'r') as file:
        json_data = json.load(file)
    for username in json_data:
        if username["username"] == user and username["password"] == psw:
            return True
    return False

def update_account_password(user, psw):
    with open('accounts.json', 'r') as file:
        json_data = json.load(file)
    for username in json_data:
        if username["username"] == user:
            username["password"] = psw
            with open("accounts.json", "w") as outfile:
                json.dump(json_data, outfile, indent=2)
            return True
    return False

def delete_account(user):
    with open('accounts.json', 'r') as file:
        json_data = json.load(file)
    for username in json_data:
        if username["username"] == user:
            del username
            with open("accounts.json", "w") as outfile:
                json.dump(json_data, outfile, indent=2)
            return True
    return False

