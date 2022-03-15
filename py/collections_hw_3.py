#Дан список поисковых запросов. Получить распределение количества слов в них. Т.е. поисковых запросов из одного
# слова - 5%, из двух -7%, из трех - 30% и т.д.

queries = ['смотреть сериалы онлайн',
           'новости спорта',
           'афиша кино',
           'курс доллара',
           'спецоперация в Украине',
           'как построить курятник своими руками',
           'Ехали медведи на велосипеде а за ними кот задом на перед',
           'Пора идти пить чай']

percents = []

summ = 0
query_percent = 0
query_percent_summ = 0
for i in queries:
    count = len(i.split())
    percents.append(count)
    summ += count

print(percents)

number_of_queryes = len(percents)
for x in range(len(percents)):
    if x == percents[x]:
        print( "Запросов с ", x, 'словом', percents.count(x) )

# print(percents)
# print(len(percents))
# number_of_queryes = len(percents)
# print(percents.count(2))

# for q in percents:
#     query_percent = (percents.count(q) / number_of_queryes) * 100
#     query_percent_summ += query_percent
#     print(q, "Запрос", query_percent, ' %')
# print(query_percent_summ)

# for i in percents:
#     print(percents.count(i))

    # count = len(i.split())
    # percents.append(count)
    # print(count)
    # summ += count

# print(summ)
# print(percents)
# for q in percents:
#     query_percent = (q / summ) * 100
#     print(f"Процентное отношение запроса {} к остальным запросам: {query_percent} %")