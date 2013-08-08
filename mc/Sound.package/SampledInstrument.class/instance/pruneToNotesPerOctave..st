other
pruneToNotesPerOctave: notesPerOctave
	"Prune all my keymaps to the given number of notes per octave."

	sustainedLoud := self midiKeyMapFor:
		(self pruneNoteList: sustainedLoud notesPerOctave: notesPerOctave).
	sustainedSoft := self midiKeyMapFor:
		(self pruneNoteList: sustainedSoft notesPerOctave: notesPerOctave).
	staccatoLoud := self midiKeyMapFor:
		(self pruneNoteList: staccatoLoud notesPerOctave: notesPerOctave).
	staccatoSoft := self midiKeyMapFor:
		(self pruneNoteList: staccatoSoft notesPerOctave: notesPerOctave).
