#Вывести на экран все уникальные geo-id из значений словаря ids. Т.е. список вида [213, 15, 54, 119, 98, 35]

ids = {'user1': [213, 213, 213, 15, 213],
       'user2': [54, 54, 119, 119, 119],
       'user3': [213, 98, 98, 35]}
# print(ids)
geos = []

for users, geo in ids.items():
    for i in geo:
        if i not in geos:
            geos.append(i)
print(geos)


