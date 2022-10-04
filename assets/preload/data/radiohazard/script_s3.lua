local fase = 0;

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
	setObjectOrder('blackbg2', 0);
	
	if ((not isStoryMode) or seenCutscene) then
		setProperty('blackbg.visible', false);
		setProperty('blackbg2.visible', false);
	end
end

function onStartCountdown()
	return onFaseChange();
end

function onEndSong()
	return onFaseChange();
end

function onFaseChange()
	fase = fase + 1;
	if ((not isStoryMode) or (fase == 1 and seenCutscene)) then
		fase = 2;
	end
	if (fase == 1) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'slideshow', '');
		runTimer('startDialogue', 0.8);
		return Function_Stop;
	elseif (fase == 2) then
		--seenCutscene = true;
	elseif (fase == 3) then
		if (not isStoryMode) then
			return Function_Continue;
		end
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'slideshow', '');
		triggerEvent('startDialogue', 'w1a3d2', '');
		playMusic('RadiCutscene4', 0, true);
		soundFadeIn('', 2, 0, 1);
		return Function_Stop;
	elseif (fase == 4) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'radi', '');
		triggerEvent('startDialogue', 'w1a3d3', '');
		return Function_Stop;
	elseif (fase == 5) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'slideshow', '');
		triggerEvent('startDialogue', 'w1a3d4', '');
		return Function_Stop;
	elseif (fase == 6) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'radi', '');
		triggerEvent('startDialogue', 'w1a3d5', '');
		return Function_Stop;
	elseif (fase == 7) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'slideshow', '');
		triggerEvent('startDialogue', 'w1a3d6', '');
		return Function_Stop;
	elseif (fase == 8) then
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'radi', '');
		triggerEvent('startDialogue', 'w1a3d7', '');
		return Function_Stop;
	elseif (fase == 9) then
		soundFadeOut('', 1.5);
		setProperty('inCutscene', true);
		triggerEvent('dialogue.setSkin', 'slideshow', '');
		triggerEvent('startDialogue', 'w1a3d8', '');
		return Function_Stop;
	elseif (fase == 10) then
		setProperty('inCutscene', true);
		triggerEvent('startDialogue', 'w1a4d1', '');
		return Function_Stop;
	elseif (fase == 11) then
		seenCutscene = true;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		--debugPrint('OUT: onEvent("startDialogue", "dialogue", "breakfast")');
		triggerEvent('startDialogue', 'w1a3d1', '');
		playMusic('RadiCutscene3', 0, true);
		soundFadeIn('', 2, 0, 1);
	end
end

function onEvent(name, value1, value2)
	if ((name == 'dialogue.skipped' and value1 == 'w1a3d1') or (name == 'Clear Blackwall')) then
		setProperty('blackbg.visible', false);
		setProperty('blackbg2.visible', false);
		soundFadeOut('', 1.5);
	elseif (name == 'dialogue.started' and value1 == 'w1a3d2') then
		setProperty('blackbg.visible', true);
		setProperty('blackbg2.visible', true);
	elseif (name == 'dialogue.skipped' and isAny(value1, 'w1a3d2', 'w1a3d3', 'w1a3d4', 'w1a3d5', 'w1a3d6', 'w1a3d7', 'w1a3d8', 'w1a4d1')) then
		setProperty('blackbg.visible', false);
		setProperty('blackbg2.visible', false);
		soundFadeOut('', 1.5);
		soundFadeOut('sfx:wind', 1.5);
		soundFadeOut('sfx:city', 1.5);
		fase = 11;
		--endSong();
	elseif (name == 'dialogue.ended' and value1 == 'w1a4d1') then
		if not (getProperty('endingSong')) then
			setProperty('blackbg.visible', false);
			setProperty('blackbg2.visible', false);
		end
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