# Напишите код для преобразования произвольного списка вида ['2018-01-01', 'yandex', 'cpc', 100] любой длины в словарь
# {'2018-01-01':{'yandex':{'cpc':100}}}
l1 = ['2018-01-01', 'yandex', 'cpc', 100]

d2 = {}
# for i in reversed(l1):
#     print(i)
#     d2[i] = i
#     l1.remove(i)
#     print(l1)
#     print(d2)
#
# print(d2)

for i in reversed(l1):
    print(i)
    d2[i] = l1[len(l1)-1]

print(d2)
# for item in reversed(l1):
#     d2[item] = item
#


# new_dict = {}
# for z in range(1, 21):
#     new_dict[z] = z ** 2
#fd
# print(new_dict)
