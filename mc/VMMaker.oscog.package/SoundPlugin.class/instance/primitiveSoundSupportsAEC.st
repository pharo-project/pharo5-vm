primitives
primitiveSoundSupportsAEC
	"Answer true if the OS/hardware supports echo-cancellation, and false otherwise."
	| result |
	self primitive: 'primitiveSoundSupportsAEC'.
	interpreterProxy failed ifFalse: [
		result := self cCode: 'snd_SupportsAEC()'.
		result == 0 ifTrue: [^interpreterProxy falseObject] ifFalse: [^interpreterProxy trueObject]
	].
