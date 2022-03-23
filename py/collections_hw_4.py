# дана статистика рекламных каналов по объемам продаж. Напишите скрипт, который возвращает название канала с максимальными объемом.
# Т.е. в данном примере скрипт должен возвращать "yandex"
stats = {'facebook': 55, 'yandex':120, 'vk': 115, 'google': 99, 'email': 42, 'ok':98}

max_count = 0
leader_key = 0

for k,v in stats.items():
    if stats[k] > max_count:
        max_count = stats[k]
        leader_key = k
print(f'Лидер по объему продаж: {leader_key}')
