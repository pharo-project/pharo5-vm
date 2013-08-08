sound library-file in/out
storeFiledInSound: snd named: sndName
	"Store the given sound in the sound library. Use the given name if it isn't in use, otherwise ask the user what to do."

	| choice i |
	(Sounds includesKey: sndName) ifFalse: [  "no name clash"
		Sounds at: sndName put: snd.
		^ self].

	(Sounds at: sndName) == UnloadedSnd ifTrue: [
		"re-loading a sound that was unloaded to save space"
		Sounds at: sndName put: snd.
		^ self].

	"the given sound name is already used"
	choice := UIManager default 
		chooseFrom: {'Replace the existing sound' translated. 'Rename the new sound' translated}
		title: ('"', sndName, '" ', 'has the same name as an existing sound' translated).
	(choice = 1) ifTrue: [
		Sounds at: sndName put: snd.
		^ self].
	(choice = 2) ifTrue: [
		i := 2.
		[Sounds includesKey: (sndName, ' v', i printString)] whileTrue: [i := i + 1].
		Sounds at: (sndName, ' v', i printString) put: snd].
