-- создаем таблицу для фамилий
CREATE TABLE IF NOT EXISTS last_name
(
    id SERIAL PRIMARY KEY
    , last_name VARCHAR(100) NOT NULL
);

-- создаем таблицу для имен
CREATE TABLE IF NOT EXISTS first_name
(
    id SERIAL PRIMARY KEY
    , first_name VARCHAR(100) NOT NULL
    , last_name_id INT
    , FOREIGN KEY (last_name_id) REFERENCES last_name(id)
);

-- создаем таблицу для отчеств
CREATE TABLE IF NOT EXISTS middle_name
(
    id SERIAL PRIMARY KEY
    , middle_name VARCHAR(100)
    , first_name_id INT
    , FOREIGN KEY (first_name_id) REFERENCES first_name(id)
);

-- вставляем данные в таблицу фамилий
INSERT
    INTO
    last_name(last_name)
VALUES ('Иванов')
       , ('Петров')
       , ('Сидоров');

/*
вставляем данные в таблицу имен
альтернативный вариант вставки внешних id:
INSERT
    INTO
    first_name(first_name, last_name_id)
SELECT
    'Иван'
    , id
FROM
    last_name
WHERE
    last_name = 'Иванов';
*/

INSERT
    INTO
    first_name(first_name, last_name_id)
VALUES ('Иван', 1)
       , ('Петр', 2)
       , ('Сидор', 3);

-- вставляем данные в таблицу отчеств
INSERT INTO middle_name(middle_name, first_name_id)
VALUES ('Иванович', 1)
       , ('Петрович', 2)
       , ('Сидорович', 3);


/*запрос, результат выполнения которого будет возвращать 
три Ф.И.О целиком в обратном алфавитном порядке (по убыванию).*/
SELECT
    CONCAT(l.last_name, ' ', f.first_name, ' ', m.middle_name) AS "Ф.И.О."
FROM
    last_name AS l
JOIN first_name AS f ON
    f.last_name_id = l.id
JOIN middle_name AS m ON
    m.first_name_id = f.id
ORDER BY
    CONCAT(l.last_name, ' ', f.first_name, ' ', m.middle_name) DESC;



