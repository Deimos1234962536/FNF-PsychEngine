local fase = 0

function onCreatePost()
	makeLuaSprite('blackbg', 'ds/dialogue/spacer', -10, -10);
	makeGraphic('blackbg', 1300, 740, '000000');
	scaleObject('blackbg', 1, 1);
	--setProperty('blackbg.alpha', 0);
	addLuaSprite('blackbg', false);
	setObjectCamera('blackbg', 'hud');
	
	makeLuaSprite('blackbg2', 'ds/dialogue/spacer', -10, -10);
	makeGraphic('blackbg2', 1300, 740, '000000');
	scaleObject('blackbg2', 1, 1);
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
		fase = 3;
	end
	if (fase == 1) then -- and isStoryMode and not seenCutscene
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'slideshow', '');
		runTimer('startDialogue', 0.8);
		return Function_Stop;
	elseif (fase == 2) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'radi', '');
		triggerEvent('startDialogue', 'w1a2d2', '');
		return Function_Stop;
	elseif (fase == 3) then
		seenCutscene = true;
	end
	return Function_Continue;
end

local music = 'RadiCutscene2';

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then
		triggerEvent('startDialogue', 'w1a2d1', '');
		playMusic(music, 0, true);
		soundFadeIn('', 2, 0, 1);
	end
end

function onEvent(name, value1, value2)
	if ((name == 'dialogue.ended' or name == 'dialogue.skipped') and value1 == 'w1a2d2') then
		removeLuaSprite('blackbg', true);
		removeLuaSprite('blackbg2', true);
		soundFadeOut('', 0.9);
	end
end