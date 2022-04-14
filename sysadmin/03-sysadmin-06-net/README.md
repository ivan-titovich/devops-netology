## Домашняя работа к занятию "3.6. Компьютерные сети, лекция 1"

1. 
```
$telnet stackoverflow.com 80
Trying 151.101.129.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0         #Запрашиваем содержимое директории /questions по протоколу HTTP/1.0 
HOST: stackoverflow.com         # c хоста stackoverflow.com

HTTP/1.1 301 Moved Permanently      # код ответа сервера о постоянном перемещении и использованиии протокола HTTP/1.1
cache-control: no-cache, no-store, must-revalidate      # Дальше идут заголовки (ключ : значение)
location: https://stackoverflow.com/questions           
x-request-guid: e136974a-31f8-4888-a496-1d8a11278f1a
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
Accept-Ranges: bytes
Date: Thu, 14 Apr 2022 13:41:29 GMT
Via: 1.1 varnish
Connection: close
X-Served-By: cache-hhn4073-HHN
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1649943690.747023,VS0,VE86
Vary: Fastly-SSL
X-DNS-Prefetch-Control: off
Set-Cookie: prov=a5cb3aa0-b987-87f1-6e4f-0fb16376030c; domain=.stackoverflow.com; expires=Fri, 01-Jan-2055 00:00:00 GMT; path=/; HttpOnly
   ```
В комментариях описал что получили в ответ на запрос.

2. 