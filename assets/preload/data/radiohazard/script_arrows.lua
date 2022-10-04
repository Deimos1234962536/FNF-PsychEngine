function onCreatePost()
	local skin = 'AltNote_assets';
	for i = 0, 3 do
		setPropertyFromGroup('playerStrums', i, 'texture', skin);
		setPropertyFromGroup('opponentStrums', i, 'texture', skin);
		--debugPrint("Changed skin of strum "..i);
	end
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') ~= 'Hurt Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', skin);
		end
	end
	setPropertyFromClass('PlayState', 'SONG.splashSkin', 'AltNoteSplashes');
end