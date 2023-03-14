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
    '3': []
}

def get_people_by_doc(documents, number):
    for document in documents:
        if (document['number'] == number ):
            result = document['name']
    return result

def get_shelf_by_doc(directories, number):
    for shelf in directories:
        x = None
        if (shelf['number'] == number ):
            result = shelf[id]
    return result


# print(get_people_by_doc(documents, "10006"))

print(get_shelf_by_doc(directories, "10006"))