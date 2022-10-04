function onCreate()
    makeLuaSprite('background', 'radi/back', 0, 0)

    makeLuaSprite('rubble', 'radi/middle', 0, 0)

    makeLuaSprite('front', 'radi/Front', 0, 0)
    setLuaSpriteScrollFactor('front', 0.9, 1)

    addLuaSprite('background', false)
    addLuaSprite('rubble', false)
    addLuaSprite('front', true)
end