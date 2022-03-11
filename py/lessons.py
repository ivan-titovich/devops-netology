# length = len('absdf')
# print(length)
#
# a = 1 + 2
# print(a)
# a = 300
# b = 34
# c = 100
# if (a > b) and (a > c):
#     if b > c :
#         print('Max is: ', b)
#     else:
#         print('max', c)
# print('max:', a)
#
# lucky ticket
# number = 927279
# a = (number // 100000)
# print(a)
# b = (number // 10000) % 10
# print(b)
# c = (number // 1000) % 10
# print(c)
# d = (number // 100) % 10
# print(d)
# e = (number // 10) % 10
# print(e)
# f = (number // 1) % 10
# print(f)
#
# if a + b + c == d + e + f:
#     print("lucky ticket!")
# else:
#     print ("unlucky, try more... :(")
#


# n = int(input("enter the number: "))
#
# if n % 2 == 1:
#     print("Weird")
# elif n >= 2 and n <= 5:
#     print("Not Weird")
# elif n >= 6 and n <= 20:
#     print("Weird")
# elif n >= 20:
#     print("Not Weird")
# else:
#     print("not working")

# if n >=3 and n <= 5:
#     print("Weird")

#
# height = 170
# age = 20
# number_of_kids = 1
# student = True
#
# if (18 < age < 27):
#   if number_of_kids >= 2:
#     print('Отсрочка от армии: более 2х детей')
#   elif student == True:
#     print('Отсрочка от армии: студент')
#   elif height < 170:
#     print('В танкисты')
#   elif height < 180:
#     print('На флот')
#   elif height < 200:
#     print('Десантники')
#   else:
#     print('В другие войска')
# else:
#   print('Непризывной возраст')



month = str(input('Введите месяц: '))
day = int(input('Введите число месяца: '))

print('Вывод: ')

if (0 < day < 21):
  print('Рыбы')