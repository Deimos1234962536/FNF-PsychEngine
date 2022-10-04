local fase = 0

function onCreatePost()
	--precacheImage('dialogue/lofie');
	precacheImage('dialogue/radibf');
	
	makeLuaSprite('blackbg', 'ds/dialogue/spacer', -10, -10);
	makeGraphic('blackbg', 1300, 740, '000000');
	scaleObject('blackbg', 1, 1);
	--setProperty('blackbg.alpha', 0);
	addLuaSprite('blackbg', false);
	setObjectCamera('blackbg', 'other');
	
	makeLuaSprite('blackbg2', 'ds/dialogue/spacer', -10, -10);
	makeGraphic('blackbg2', 1300, 740, 'FFFFFF');
	scaleObject('blackbg2', 1, 1);
	setProperty('blackbg2.visible', false);
	addLuaSprite('blackbg2', false);
	setObjectCamera('blackbg2', 'other');
	
	if ((not isStoryMode) or seenCutscene) then
		setProperty('blackbg.visible', false);
		setProperty('blackbg2.visible', false);
	end
end

function onStartCountdown()
	fase = fase + 1;
	if ((not isStoryMode) or (fase == 1 and seenCutscene)) then
		fase = 5;
	end
	if (fase == 1) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'slideshow', '');
		runTimer('startDialogue', 0.8);
		return Function_Stop;
	elseif (fase == 2) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'lofie', '');
		triggerEvent('startDialogue', 'w2a1d2', '');
		return Function_Stop;
	elseif (fase == 3) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'slideshow', '');
		triggerEvent('startDialogue', 'w2a1d3', '');
		return Function_Stop;
	elseif (fase == 4) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'lofie', '');
		triggerEvent('startDialogue', 'w2a1d4', '');
		return Function_Stop;
	elseif (fase == 5) then
		removeLuaSprite('blackbg', true);
		removeLuaSprite('blackbg2', true);
		seenCutscene = true;
	end
	return Function_Continue;
end

local music = 'LofieCutscene1';

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then
		triggerEvent('startDialogue', 'w2a1d1', '');
		playMusic(music, 0, true);
		soundFadeIn('', 2, 0, 1);
	end
end

function onEvent(name, value1, value2)
	if (name == 'dialogue.step' and value1 == 'w2a1d2' and value2 == '8') then
		setProperty('blackbg2.visible', true);
	elseif (name == 'dialogue.step' and value1 == 'w2a1d4' and value2 == '3') then
		setProperty('blackbg2.visible', false);
	elseif (name == 'dialogue.skipped' and isAny(value1, 'w2a1d1', 'w2a1d2', 'w2a1d3', 'w2a1d4')) then
		setProperty('blackbg.visible', false);
		setProperty('blackbg2.visible', false);
		soundFadeOut('', 0.9);
		fase = 4;
	elseif (name == 'dialogue.ended' and value1 == 'w2a1d4') then
		setProperty('blackbg.visible', false);
		setProperty('blackbg2.visible', false);
		soundFadeOut('', 0.9);
	end
end

function isAny(val, ...)
	local args = { ... };
	for _, target in ipairs(args) do
		if (val == target) then
			return true;
		end
	end
	return false;
end