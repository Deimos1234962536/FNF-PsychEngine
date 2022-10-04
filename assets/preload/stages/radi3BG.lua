function onCreate()
    makeLuaSprite('background', 'radi/back3', 0, 0)

    makeLuaSprite('rubble', 'radi/middle3', 0, 0)

    makeAnimatedLuaSprite('smoke', 'radi/Smoke', -900, -600)
    addAnimationByPrefix('smoke', 'idle', 'RadiFartAnim0', 24, true)
    scaleObject('smoke', 4, 4)

    makeLuaSprite('front', 'radi/Front3', 0, 0)
    setLuaSpriteScrollFactor('front', 0.9, 1)

    addLuaSprite('background', false)
    addLuaSprite('rubble', false)
    addLuaSprite('smoke', false)
    addLuaSprite('front', true)

    objectPlayAnimation('smoke', 'idle', true)
end