accessing
allSampleSets: sortedNotes

	| keyMap |
	keyMap := self midiKeyMapFor: sortedNotes.
	sustainedSoft := keyMap.
	sustainedLoud := keyMap.
	staccatoSoft := keyMap.
	staccatoLoud := keyMap.
