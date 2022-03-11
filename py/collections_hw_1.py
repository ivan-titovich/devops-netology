#Дан список с визитами по городам и странам. Напишите код, который возвращает отфильтрованный список geo_logs, \
#содержащий только визиты из России.

geo_logs = [
    {'visit1': ['Москва', 'Россия']},
    {'visit2': ['Дели', 'Индия']},
    {'visit3': ['Владимир', 'Россия']},
    {'visit4': ['Лиссабон', 'Португалия']},
    {'visit5': ['Париж', 'Франция']},
    {'visit6': ['Лиссабон', 'Португалия']},
    {'visit7': ['Тула', 'Россия']},
    {'visit8': ['Тула', 'Россия']},
    {'visit9': ['Курск', 'Россия']},
    {'visit10': ['Архангельск', 'Россия']},
]

# это список со словарем внутри (visit - ключ), внутри значения ключа - еще список
geo_logs_sorted_list = []
geo_logs_sorted ={}


for visits in geo_logs:
    for k, v in visits.items():
        if v[1] == 'Россия':
            geo_logs_sorted.setdefault(k,v)

        geo_logs_sorted_list.append(geo_logs_sorted)

print(geo_logs)
print()
print()
print(geo_logs_sorted_list)