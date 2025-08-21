### Системный API (`zone.graphics`)

#### `zone.graphics.present()`

Вызывается для отрисовки всей графики.

-   **Аргументы:** нет.
-   **Возвращает:**
    -   `nil` (ничего).
-   **Примечание:**
    -   В headless режиме функция не будет вызываться, ибо графики в нём нет.

> [!IMPORTANT]
> **Важно!** Функцию **не нужно** вызывать просто так, она делает это сама.
 Вызывайте её только тогда, когда модифицируете функцию `zone.run`.

---

#### `zone.graphics.setBackgroundColor()`

Устанавливает цвет заднего фона в диапазоне от 0 до 255.

-   **Аргументы:** 
    -   `r: number` — красный цвет.
    -   `g: number` — зелёный цвет.
    -   `b: number` — синий цвет.
    -   `a: number` — уровень прозрачности.
-   **Возвращает:**
    -   `nil` (ничего).
 
---

#### `zone.graphics.setFillColor()`

Устанавливает цвет заливки диапазоне от 0 до 255.

-   **Аргументы:** 
    -   `r: number` — красный цвет.
    -   `g: number` — зелёный цвет.
    -   `b: number` — синий цвет.
    -   `a: number` — уровень прозрачности.
-   **Возвращает:**
    -   `nil` (ничего).
 
---

#### `zone.graphics.rect()`

Рисует квадрат по указанным координатам с шириной и высотой.

-   **Аргументы:** 
    -   `x: number` — позиция x.
    -   `y: number` — позиция y.
    -   `width: number` — ширина.
    -   `height: number` — высота.
    -   `mode: string` — тип заливки. `fill` — отрисовка с заполнением внутри, `bevel` — отрисовка только рамки.
-   **Возвращает:**
    -   `nil` (ничего).
 
---

#### `zone.graphics.circle()`

Рисует круг по указанным координатам с радиусом.

-   **Аргументы:** 
    -   `x: number` — позиция x.
    -   `y: number` — позиция y.
    -   `radius: number` — радиус.
-   **Возвращает:**
    -   `nil` (ничего).
 
---

#### `zone.graphics.polygon()`

Рисует полигон по данным точкам.

-   **Аргументы:** 
    -   `vertices: { {x: number, y: number} }` — точки полигона.
-   **Возвращает:**
    -   `nil` (ничего).
 
---

#### `zone.graphics.newImage()`

Загружает спрайт в память движка.

-   **Аргументы:** 
    -   `path: string` — путь к изображению **внутри zpak**.
-   **Возвращает:**
    -   `any` (изображение).
 
---

#### `zone.graphics.image()`

Загружает спрайт в память движка.

-   **Аргументы:** 
    -   `image: any` — изображение.
    -   `x: number` — позиция x.
    -   `y: number` — позиция y.
    -   `w: number?` — (необязательно) ширина конечной картинки.
    -   `w: number?` — (необязательно) высота конечной картинки.
-   **Возвращает:**
    -   `nil` (ничего).
 
---

#### `zone.graphics.newFont()`

Загружает шрифт в память движка.

-   **Аргументы:** 
    -   `path: string` — путь к шрифту **внутри zpak**.
    -   `size: number` — размер шрифта.
    -   `format: string` — формат шрифта. `ttf` или `otf`.
-   **Возвращает:**
    -   `any` (шрифт).
 
---


#### `zone.graphics.echo()`

Рисует текст на определённых координатах с указанным шрифтом.

-   **Аргументы:** 
    -   `font: any` — шрифт.
    -   `text: string` — текст для отрисовки.
    -   `x: number` — позиция x.
    -   `y: number` — позиция y.
    -   `baseSize: number?` — (необязательно) установка размера текста.
-   **Возвращает:**
    -   `nil` (ничего).

> [!WARNING]
> **Внимание!** Не рекомендуется использовать `baseSize` для увеличения размера исходного шрифта так как в результате получится
 пиксельное месиво. При загрузке шрифта **вы** задаёте размер шрифта, который будет являться единственным адекватным его
 размером.

---

#### `zone.graphics.getStringSize()`

Возвращает графические размеры строки, которую вы указали.

-   **Аргументы:** 
    -   `font: any` — шрифт.
    -   `text: string` — текст.
-   **Возвращает:**
    -   `number` (позиция x).
    -   `number` (позиция y).

---

#### `zone.graphics.clip()`

Обрезает область рисования. Если не передать аргументы, то область вернётся к исходному состоянию, т.е ширина и высота окна.

-   **Аргументы:** 
    -   `x: number?` — позиция x.
    -   `y: number?` — позиция y.
    -   `width: number?` — ширина.
    -   `height: number?` — высота.
-   **Возвращает:**
    -   `nil` (ничего).
-   **Пример:**
    ```lua
    function zone.draw()
        zone.graphics.clip(0, 0, 100, 100) -- Ограничеваем область рисования до куба 100 на 100
        zone.graphics.setFillColor(255, 0, 0, 255)
        zone.graphics.rect(0, 0, 256, 256, 'fill')
        zone.graphics.clip() -- Сбрасываем область рисования
    end -- Увидим красный куб размерами 100 на 100, даже если его реальная ширина и высота будет 1000 на 1000.
    ```

---

#### `zone.graphics.push()` и `zone.graphics.pop()`

`push:` Сохраняет настройки трансформаций (`zone.graphics.translate`, `zone,graphics.scale`, `zone.graphics.rotate`).
`pop:` Возвращает последние сохраненные настройки сделанные `zone.graphics.push`.

-   **Аргументы:** нет.
-   **Возвращает:**
    -   `nil` (ничего).
-   **Пример:**
    ```lua
    function zone.draw()
        zone.graphics.setFillColor(255, 0, 0, 255)
        zone.graphics.push() -- Сохраяем исходные настройки, т.е rotate = 0
        zone.graphics.rotate(65) -- Поворачиваем матрицу на 65 градусов
        zone.graphics.rect(0, 0, 100, 100)
        zone.graphics.pop() -- Возвращаем сохранённые настройки, и rotate теперь равен 0
        zone.graphics.setFillColor(255, 255, 255, 255)
        zone.graphics.rect(100, 0, 100, 100)
    end
    ```

---

#### `zone.graphics.translate()`

Перемещает матрицу на указанные координаты.

-   **Аргументы:**
    -   `x: number` — позиция x.
    -   `y: number` — позиция y.
-   **Возвращает:**
    -   `nil` (ничего).

---

#### `zone.graphics.rotate()`

Поворачивает матрицу на указанные координаты.

-   **Аргументы:**
    -   `angle: number` — угол поворота.
-   **Возвращает:**
    -   `nil` (ничего).

---

#### `zone.graphics.scale()`

Увеличивает контент на указанные множители. `zone.graphics.scale(1, 1)` возвращает обычный размер.

-   **Аргументы:**
    -   `sx: number` — увеличение по x.
    -   `sy: number` — увеличение по y.
-   **Возвращает:**
    -   `nil` (ничего).

---

#### `zone.graphics.setImageScaleMode()`

Устанавливает спрайту режим scaling-а.

-   **Аргументы:**
    -   `image: any` — целевой спрайт.
    -   `mode: string` — режим. `linear` - линейный, `nearest` - подходит для пиксель-артов. `pixelart` - тоже.
-   **Возвращает:**
    -   `nil` (ничего).
-   **Примечание:**
    -   По умолчанию установлен режим **linear**.

---

#### `zone.graphics.newShader()`

Компилирует и сохраняет в память новый шейдер.

-   **Аргументы:**
    -   `fs: string` — код фрагментного шейдера.
    -   `vs: string` — код вершинного шейдера.
-   **Возвращает:**
    -   `nil` (ничего).

---


#### `zone.graphics.useShader()`

Заставляет движок использовать указанный шейдер. Не передавая аргумент шейдер сбросится до стандартного.

-   **Аргументы:**
    -   `shader: any` — объект шейдера.
-   **Возвращает:**
    -   `nil` (ничего).
-   **Пример:**
    ```lua
    function zone.init()
        img = zone.graphics.newImage('block.jpg')
        shader = zone.graphics.newShader("", [[
    #version 100

    precision mediump float;

    // Input vertex attributes (from vertex shader)
    varying vec2 fragTexCoord;
    varying vec4 fragColor;

    // Input uniform values
    uniform sampler2D texture0;
    uniform vec4 colDiffuse;

    // NOTE: Add your custom variables here

    void main()
    {
        // Texel color fetching from texture sampler
        vec4 texelColor = texture2D(texture0, fragTexCoord)*colDiffuse*fragColor;

        // Convert texel color to grayscale using NTSC conversion weights
        float gray = dot(texelColor.rgb, vec3(0.299, 0.587, 0.114));

        // Calculate final fragment color
        gl_FragColor = vec4(gray, gray, gray, texelColor.a);
    }
    ]])
    end

    function zone.draw()
        zone.graphics.useShader(shader) -- Начинаем использовать шейдер
        local x = 0 
        local y = 150
        local ww, wh = zone.window.getSize()
        for i = 1, 128 do
            zone.graphics.image(img, x, y, 64, 64)
            x += 32
            if x > ww then
                x = 0
                y += 32
            end
        end
        zone.graphics.useShader() -- Сбрасываем шейдер
    end
    ```
---