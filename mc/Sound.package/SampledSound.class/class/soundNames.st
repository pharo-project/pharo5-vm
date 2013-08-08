sound library
soundNames
	"Answer a list of sound names for the sounds stored in the sound library."
	"| s |
	 SampledSound soundNames asSortedCollection do: [:n |
		n asParagraph display.
		s := SampledSound soundNamed: n.
		s ifNotNil: [s playAndWaitUntilDone]]"

	^ SoundLibrary keys asArray
