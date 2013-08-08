other
pruneToSingleNote: aNote
	"Fill all my keymaps with the given note."

	| oneNoteMap |
	oneNoteMap := Array new: 128 withAll: aNote.
	sustainedLoud := oneNoteMap.
	sustainedSoft := oneNoteMap.
	staccatoLoud := oneNoteMap.
	staccatoSoft := oneNoteMap.
