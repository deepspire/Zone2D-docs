# Глобальное пространство имен
Основные функции движка находятся здесь.

## Коллбэки
#### `zone.update`
-   **Аргументы:**
    -   `dt: number` — время, прошедшее с предыдущего кадра в секундах.
    Этот `dt` всегда будет идентичен тому, что возвращает `zone.system.dt()` в контексте текущего кадра.
-   **Возвращает:**
    -   `nil` (ничего).
-   **Примечание:**
    -   Аргумент `dt` будет всегда идентичен результату функции `zone.system.dt()`.
    -   Для работы сокетов нужно каждый кадр вызывать `zone.socket.update()`.
-   **Пример:**
    ```lua
    local timer = 0

    function zone.update(dt: number)
        zone.socket.update()

        timer += dt
        if timer >= 1 then
            timer = 0

            print("Прошла одна секунда!")
        end
    end
    ```
#### `zone.cleanup`
Обычно вызывается тогда, когда движок собирается удалить `Luau State` (состояние луау).
-   **Аргументы:** нет.
-   **Возвращает:**
    -   `nil` (ничего).
## Свойства
#### `zone.isHeadless`
Имеет тип `boolean`. По умолчанию `false`.

Поле будет `true`, если движок будет запущен с аргументом `--headless`.
    
## Ссылки
<details>
<summary>Пространства имен</summary>

-   [**zone.system**](system/readme.md) — системные функции.
-   [**zone.event**](event/readme.md) — функции связанные с событиями.
-   [**zone.graphics**](graphics/readme.md) — работа с графикой.
-   [**zone.byteStream**](bytestream/readme.md) — работа с бинарными данными.
-   [**zone.socket**](socket/readme.md) — всё, что связано с TCP соединениями.

</details>

  
