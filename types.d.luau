declare class ByteStreamClass
    function writeInt(self, value: number): ()
    function readInt(self): number

    function writeVInt(self, value: number): ()
    function readVInt(self): number

    function writeVUInt(self, value: number): ()
    function readVUInt(self): number

    function writeString(self, value: string): ()
    function readString(self): string

    function seek(self, offset: number): ()
    function getOffset(self): number

    function prepend(self, len: number): ()
    
    function getTable(self): {number}
    function toString(self): string
end

declare class NetConnection
    function getIp(self): string
    function send(self, data: ByteStreamClass): number
    function close(self): ()
    function onDisconnect(self, callback: () -> ()): ()
end

declare class ClosableSocket
    function close(self): ()
end

declare class ClientClass extends ClosableSocket
    function connect(self, ip: string, port: number, callback: (connection: NetConnection) -> ()): ()
end

declare class ServerClass extends ClosableSocket
    function listen(self, port: number, ip: string?, callback: (connection: NetConnection) -> ()): ()
end

-- abstract classes
declare class Body
end
declare class ZoneImage
end
declare class ZoneFont
end
declare class ZoneSound
end

declare zone: {
    isHeadless: boolean,

    system: {
        log: (...any) -> (),
        warn: (...any) -> (),
        quit: () -> (),
        dt: () -> number,
        getPlatform: () -> ("windows" | "linux" | "android" | "apple"),
        freeCache: () -> (),
        setLuaExecutorEnabled: (enabled: boolean) -> (),
        getEnvironment: () -> ("simulator" | "device"),
        hashString: (tohash: string, method: ("xxhash" | "md5"), seed: string?) -> string,
        delay: (seconds: number) -> (),
        vibrate: (seconds: number, strength: number) -> (),
        setTargetFPS: (fps: number) -> ()
    },

    graphics: {
        present: () -> (),

        newImage         : (path: string, isNativePath: boolean) -> ZoneImage,
        newPicture         : (path: string, isNativePath: boolean) -> ZoneImage,
        setImageScaleMode: (image: ZoneImage, mode: ("linear" | "nearest" | "pixelart")) -> (),
        newFont          : (path: string, size: number, format: 'ttf' | 'otf') -> ZoneFont,

        newSpriteSheet: (fileName: string, width: number, height: number, rows: number, cols: number, frameWidth: number, frameHeight: number,
                         paddingX: number?, paddingY: number?, initialPaddingX: number?, initialPaddingY: number?) -> any,

        image: (image: ZoneImage, x: number, y: number, w: number?, h: number?) -> (),
        echo: (font: ZoneFont, text: string, x: number, y: number, baseSize: number?) -> (),

        rect: (x: number, y: number, w: number, h: number, mode: "fill" | "bevel", radius: number?) -> (),
        circle: (x: number, y: number, radius: number, sides: number) -> (),
        polygon: (vertices: { {x: number, y: number} }, close: boolean?) -> (),

        push: () -> (),
        pop: () -> (),

        setBackgroundColor: (r: number, g: number, b: number, a: number) -> (),
        setFillColor: (r: number, g: number, b: number, a: number) -> (),

        translate: (x: number, y: number) -> (),
        rotate: (angle: number) -> (),
        scale: (sx: number, sy: number) -> (),

        newShader: (vs: string, fs: string) -> any,
        useShader: (shader: any?) -> (),

        getStringSize: (font: any, text: string) -> (number, number),
        clip: (x: number?, y: number?, w: number?, h: number?) -> (),
        getSubImage: (image: any, x: number, y: number, width: number, height: number) -> any,
        sheetFrame: (sheet: any, frameNumber: number, x: number, y: number, width: number?, height: number?) -> (),
        getFrameCount: (sheet: any) -> number,
        setShaderProperty: (shader: any, prop: string, v1: any, v2: any?, v3: any?, v4: any?) -> (),
        getDimensions: (image: any) -> (number, number),
        genPictureColor: (width: number, height: number, r: number, g: number, b: number, a: number) -> any,
        imageDrawRoundRect: (dest: any, width: number, height: number, cornerRadius: number, r: number, g: number, b: number, a: number) -> (),
        alphaMask: (dst: any, src: any) -> (),
        renderPicture: (picture: any) -> any,
        unloadImage: (imageOrPicture: any) -> (),
        unloadFont: (font: any) -> (),
        line: (startX: number, startY: number, endX: number, endY: number) -> (),
    },

    utf8: {
        sub: (src: string, from: number, to: number) -> string,
        len: (src: string) -> number,
        chars: (...string) -> string,
        codepoint: (src: string, i: number, j: number) -> (...number)
    },

    window: {
        getSize: () -> (number, number),
        setSize: (w: number, h: number) -> (),

        isFullscreen: () -> boolean,
        setFullscreen: (enabled: boolean) -> (),

        setTitle: (title: string) -> (),

        setMinimumSize: (width: number, height: number) -> (),
        setMaximumSize: (width: number, height: number) -> (),

        setModal: (a: boolean) -> (),
        setResizable: (a: boolean) -> (),
        setBordered: (a: boolean) -> (),
    },

    event: {
        poll: () -> {},
        flush: () -> (),
        lastKey: () -> (string, boolean),
        getMousePosition: () -> (number, number),
        getFingerID: () -> number,
        pointIntersects: (x: number, y: number, rx: number, ry: number, rw: number, rh: number) -> boolean,
        setClipboardText: (value: string) -> (),
        getClipboardText: () -> string,
        isKeyDown: (key: string) -> boolean,
        bind: (name: string, keys: {string}) -> (),
        isPressed: (name: string) -> boolean,
        isReleased: (name: string) -> boolean,
        getPressed: (pos: number) -> string,
        getReleased: (pos: number) -> string,
    },

    physics: {
        init: () -> (),
        newBoxBody: (x: number, y: number, rotation: number, w: number, h: number, body: "static" | "dynamic", density: number?, friction: number?, restitution: number?) -> Body,
        newCircleBody: (x: number, y: number, rotation: number, radius: number, bodyType: "static" | "dynamic", density: number?, friction: number?, restitution: number?) -> Body,
        setGravity: (x: number, y: number) -> (),
        applyForce: (body: Body, xForce: number, yForce: number) -> (),
        applyLinearImpulse: (body: Body, xForce: number, yForce: number) -> (),

        getBodyPosition: (body: Body) -> (number, number),
        getBodyRotation: (body: Body) -> (number),
        removeBody: (body: Body) -> (),
        setHitboxesEnabled: (enabled: boolean) -> (),
    },

    audio: {
        newSound: (path: string) -> ZoneSound,
        play: (sound: ZoneSound) -> (),
        stop: (sound: ZoneSound) -> (),
        isPlaying: (sound: ZoneSound) -> (),
        setVolume: (sound: ZoneSound, volume: number) -> (),
    },

    fs: {
        getFilePath: (filePath: string) -> string,
        read: (filePath: string) -> (string | nil),
        write: (filePath: string, content: string) -> (true | false),
        readResource: (filePath: string) -> (string | nil),
        remove: (filePath: string) -> (true | false),
        copy: (filePath: string) -> (true | false),
        mkdir: (dirPath: string) -> (true | false),
        rmdir: (dirPath: string) -> (true | false),
        rename: (from: string, to: string) -> (),
        exists: (path: string) -> (true | false),
        size: (path: string) -> number,
        list: (dirPath: string) -> any,
    },

    web: {
        openURL: (url: string) -> (true | false),
        newConnection: (url: string) -> any,
        get: (path: string) -> {},
    },

    byteStream: {
        new: () -> ByteStreamClass,
        fromString: (source: string) -> ByteStreamClass
    },

    socket: {
        server: {
            new: () -> ServerClass
        },

        client: {
            new: () -> ClientClass
        },

        update: () -> (),
    },

    cleanup: () -> (),
    init: () -> (),
    draw: () -> (),
    update: () -> (),
    mousepressed: (mx: number, my: number, fingerId: number) -> (),
    mousereleased: (mx: number, my: number, fingerId: number) -> (),
    keypressed: (key: string) -> (),
    keyreleased: (key: string) -> (),
    resized: (width: number, height: number) -> ()
}