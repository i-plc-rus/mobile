# Используем Node.js версии 18, которая поддерживает современный синтаксис
FROM node:18

# Устанавливаем json-server глобально
RUN npm install -g json-server

# Создаем рабочую директорию
WORKDIR /app

# Копируем db.json в контейнер
COPY db.json /app/db.json

# Открываем порт 3000 для доступа к JSON Server
EXPOSE 3000

# Команда для запуска JSON Server
CMD ["json-server", "--host", "0.0.0.0", "--watch", "db.json"]
