# rambler_perl_test1

## Общее описание

Запуск приложения с использованием тестового файла: 
    ./get_images_sizes.pl ./test.html

Запуск теста:
    ./get_images_sizes.t

## Архитектура приложения для получения размера картинок для постов

Схема архитектуры - в файле architect.pdf.

### Общее описание

Т.к. подразумеваются большие объемы и возможна большая мгновенная нагрузка по данной задаче, необходим горизонтально масштабируемый вариант. Это подразумевает собой реализацию задачи с разбивкой на несколько систем:

1. Менеджер постановки задачи в очередь. Представляет собой монитор (наблюдатель), которая определяет добавление новых статей, изменение статей (с отслеживанием набора картинок), удаление статей (для удаления ненужных данных о картинках). По результатам отслеживания производится постановка картинки в очередь на получение данных или в очередь на удаление. Очередь на удаление нужна для того, чтобы не грузить бэкэнд процесс этой операцией, задерживая отдачу контента.
2. Обработчик-воркер, получающий данные о картинке. Представляет собой постоянно работающий процесс, отслеживающий состояние очереди задач. Получая из очереди задачу на обработку картинки, скачивает ее с сервера, анализирует ее размер и размещает данные о размере в базу. Здесь-же (в начале процесса) обрабатывается ситуация наличия данной картинки в обработанных (по данным из базы).
3. Обработчик удаленных картинок. Отдельный процесс, который периодически сканирует базу, определяет данные картинок без ссылок на них из статей и удаляет их (не показан на схеме архитектуры).

### Способ хранения данных о размере картинок

Для этого необходимы две дополнительные таблицы:

Таблица с данными по картинке: 
 
- id (хэш sha256 от URL картинки в бинарном виде в качестве первичного ключа)
- width
- height

Таблица связи статьи с данными по картинкам:
 
- post_id - идентификатор статьи
- image_id - идентификатор картинки (sha256)

### Используемые модули:

- HTTP::Async - для запросов на получение картинок;
- Image::Magick - для определения размера картинки (можно поискать что-то более легковесное, но это универсальный вариант);
- HTML::LinkExtor - для извлечения линков из HTML.

### Особенности решения

Необходимо предусмотреть все нужные блокировки между поиском существующей картинки и добавление для нее связи между статьей и картинкой. Если этого не будет, может получиться так, что удаление данных картинки сработает сразу после того, как пройдет проверка на существование в обработчике-воркере и тогда будет создан линк на удаленную картинку.

Возможна ситуация когда картинка изменится на самом хостинге. Решением может быть запоминание в данных картинки даты ее последнего времени анализа и периодический проход по всем картинкам с HTTP запросом HEAD. Кроме того, что это позволит определять изменившиеся картинки, это-же позволит обнаруживать не актуальные больше картинки и вставить в статью вместо них разумную замену, указывающую на это.
