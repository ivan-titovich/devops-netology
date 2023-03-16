# Список со словарями
documents = [
    {"type": "passport", "number": "2207 876234", "name": "Василий Гупкин"},
    {"type": "invoice", "number": "11-2", "name": "Геннадий Покемонов"},
    {"type": "insurance", "number": "10006", "name": "Аристарх Павлов"}
]

# Словари со списками
directories = {
    '1': ['2207 876234', '11-2'],
    '2': ['10006'],
    '3': ['9899'],
    '4': ['321']
}




def get_people_by_doc(documents, number):
    for document in documents:
        result = "ОШИБКА! Введенный номер документа не найден."
        if (document['number'] == number ):
            result = document['name']
    return result

def get_shelf_by_doc(directories, number):
    directory = "ОШИБКА! Указанный номер полки не найден."
    for shelf in directories:
        for row in directories[shelf]:
            if ( row == number):
                directory = shelf
    return directory


def doc_list(documents):
    for document in documents:
        print(f"{document['type']}, \"{document['number']}\",\"{document['name']}\"")


def directories_list(directories):
    for shelf in directories:
        print(f"на полке №", shelf , ": ")
        for list in directories[shelf] :
            print(list)

def add_to_dict(documents, directories, user_type_input, user_number_input, user_name_input, user_directory_input):

    print(f"user_directory_input", user_directory_input)
    if user_directory_input in directories:
        directories[user_directory_input].append(user_number_input)
        documents.append({"type": user_type_input, "number": user_number_input, "name": user_name_input})
    else :
        print("ОШИБКА! Нет полки с указанным номером! ")




# print("_______________________________________________________")
# print(get_people_by_doc(documents, "10006"))
# print("_______________________________________________________")
# print(get_shelf_by_doc(directories, "321"))
# print("_______________________________________________________")
# print(doc_list(documents))
# print("_______________________________________________________")

def main(documents, directories):
    while True:
        user_input = input('Введите команду: ')
        if user_input == 'p':
            user_number = input('Введите номер документа для поиска:')
            print(get_people_by_doc(documents, user_number))
        elif user_input == 's':
            user_number1 = input('Введите номер документа для поиска на стеллаже:')
            print(get_shelf_by_doc(directories, user_number1))
        elif user_input == 'l':
            print(doc_list(documents))
        elif user_input == 'a':
            user_type_input = input('Введите тип документа (eng): ')
            user_number_input = input('Введите номер документа: ')
            user_name_input = input('Введите имя владельца документа (rus): ')
            user_directory_input = input('Введите номер полки для документа: ')
            print(add_to_dict(documents, directories, user_type_input, user_number_input, user_name_input, user_directory_input))
            print()
            print(doc_list(documents))
            print()
            print(directories_list(directories))
        elif user_input == 'ld' :
            print(directories_list(directories))
        elif user_input == 'q':
            break

main(documents, directories)