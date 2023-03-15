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


def add_to_dict(documents, directories, user_type_input, user_number_input, user_name_input):
    # print(user_type_input, user_number_input, user_name_input, user_directies_input)
    for doc in documents:
        doc['type'] = user_type_input
        doc['number'] = user_number_input
        doc['name'] = user_name_input



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
            # user_directies_input = input('Введите номер стеллажа: ')
            print(add_to_dict(documents, directories, user_type_input, user_number_input, user_name_input))

        elif user_input == 'q':
            break

main(documents, directories)