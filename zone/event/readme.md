### Системный API (`zone.event`)

#### `zone.event.poll()`

Возвращает таблицу событий движка за кадр, используется в root функции.

-   **Аргументы:** нет.
-   **Возвращает:**
    -   `{string}` — таблица событий.

---

#### `zone.event.lastKey()`

Возвращает последнюю нажатую клавишу.

-   **Аргументы:** нет.
-   **Возвращает:**
    -   `string` — клавиша.

---

#### `zone.event.getMousePosition()`

Возвращает позицию мыши относительно окна, т.е 0, 0 - левый верхний угол

-   **Аргументы:** нет.
-   **Возвращает:**
    -   `integer` — позиция x.
    -   `integer` — позиция y.

---

#### `zone.event.pointIntersects()`

Проверяет нахождение точки (x, y) внутри данного прямоугольника.

| Аргумент | Тип                               | Описание                                                                                                                              |
| :------- | :-------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------ |
| `mouseX` | `integer`                         | Позиция входной точки X                                                                                                               |
| `mouseY` | `integer`                         | Позиция входной точки Y                                                                                                               |
| `rX`     | `integer`                         | Позиция прямоугольника X                                                                                                              |
| `rY`     | `integer`                         | Позиция прямоугольника Y                                                                                                              |
| `rW`     | `integer`                         | Ширина прямоугольника                                                                                                                 |
| `rY`     | `integer`                         | Высота прямоугольника                                                                                                                 |


-   **Возвращает:**
    -   `integer` — позиция x.
    -   `integer` — позиция y.

---

#### `zone.event.setClipboardText()`

Копирует указанный текст в буфер обмена.

-   **Аргументы:**
    -   `text: string` — текст, который нужно положить в буфер обмена.
-   **Возвращает:**
    -   `nil` (ничего).

---

#### `zone.event.getClipboardText()`

Возвращает текст, который лежит в буфере обмена.

-   **Аргументы:** нет.
-   **Возвращает:**
    -   `string` — полученный текст.

---

#### `zone.event.bind()`

Помогает проверять на нажатие сразу несколько кнопок под одним унифицированным названием.

-   **Аргументы:**
    -   `name: string` — имя, которое будет дано новой группе клавиш.
    -   `keys: {string}` — клавиши, которые будут сверяться.
-   **Возвращает:**
    -   `nil` (ничего).
-   **Пример:**
    ```lua
    function zone.init()
        moves = {}
        moves.left = false
        moves.right = false
        moves.top = false
        moves.bottom = false
        zone.event.bind("left", {"a", "left"})
        zone.event.bind("right", {"d", "right"})
        zone.event.bind("top", {"w", "up"})
        zone.event.bind("bottom", {"s", "down"})
        moves.x = 0
        moves.y = 0

        moves.icon = zone.graphics.newPicture("block.jpg", false)
        local w, h = zone.graphics.getDimensions(moves.icon)
        moves.mask = zone.graphics.genPictureColor(w, h, 0, 0, 0, 0)
        zone.graphics.imageDrawRoundRect(moves.mask, w, h, 200, 255, 255, 255, 255)
        zone.graphics.alphaMask(moves.mask, moves.icon)
        zone.graphics.unloadImage(moves.mask)
        moves.texture = zone.graphics.renderPicture(moves.icon)
    end

    function zone.cleanup()
        zone.graphics.unloadImage(moves.texture)
    end

    function zone.draw()
        zone.graphics.setBackgroundColor(0, 200, 255, 255)
        zone.graphics.setFillColor(255, 255, 255, 255)
        zone.graphics.push()
        zone.graphics.translate(moves.x, moves.y)
        zone.graphics.image(moves.texture, moves.x, moves.y, 100, 100)
        zone.graphics.pop()
    end

    function zone.update(dt)
        if moves.left then
            moves.x -= dt*200
        end
        if moves.right then
            moves.x += dt*200
        end
        if moves.bottom then
            moves.y += dt*200
        end
        if moves.top then
            moves.y -= dt*200
        end
    end

    function zone.keypressed(key, isRepeat)
        if not isRepeat then
            if zone.event.isPressed("left") then
                moves.left = true
            end

            if zone.event.isPressed("right") then
                moves.right = true
            end

            if zone.event.isPressed("top") then
                moves.top = true
            end
            if zone.event.isPressed("bottom") then
                moves.bottom = true
            end
        end
    end

    function zone.keyreleased(key, isRepeat)
        if zone.event.isReleased("left") then
            moves.left = false
        end
        if zone.event.isReleased("right") then
            moves.right = false
        end
        if zone.event.isReleased("top") then
            moves.top = false
        end
        if zone.event.isReleased("bottom") then
            moves.bottom = false
        end
    end
    ```
---

#### `zone.event.isPressed()`

Проверяет, нажата ли хотя бы одна клавиша из группы клавиш.

-   **Аргументы:**
    -   `name: string` — имя существующей группы клавиш.
-   **Возвращает:**
    -   `boolean` — вернет true если нажато, и false если нет.

---

#### `zone.event.isReleased()`

Проверяет, отжата ли хотя бы одна клавиша из группы клавиш.

-   **Аргументы:**
    -   `name: string` — имя существующей группы клавиш.
-   **Возвращает:**
    -   `boolean` — вернет true если отжато, и false если нет.

---

#### `zone.event.getPressed()`

Возвращает нажатую клавишу по позиции в стеке событий.

-   **Аргументы:**
    -   `pos: number` — порядковый номер в стеке событий.
-   **Возвращает:**
    -   `string` — клавиша.

---

#### `zone.event.getReleased()`

Возвращает отжатую клавишу по позиции в стеке событий.

-   **Аргументы:**
    -   `pos: number` — порядковый номер в стеке событий.
-   **Возвращает:**
    -   `string` — клавиша.

---