other
pruneNoteList: aNoteList notesPerOctave: notesPerOctave
	"Return a pruned version of the given note list with only the given number of notes per octave. Assume the given notelist is in sorted order."

	| r interval lastPitch |
	r := OrderedCollection new: aNoteList size.
	interval := (2.0 raisedTo: (1.0 / notesPerOctave)) * 0.995.
	lastPitch := 0.0.
	aNoteList do: [:n |
		n pitch > (lastPitch * interval) ifTrue: [
			r addLast: n.
			lastPitch := n pitch]].
	^ r
