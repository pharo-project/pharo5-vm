primitives
primitiveSoundEnableAEC: trueOrFalse 
	"Enable or disable acoustic echo-cancellation (AEC).  trueOrFalse should be 0 for false, and 1 for true."
	| result |
	self primitive: 'primitiveSoundEnableAEC' parameters: #(SmallInteger ).
	interpreterProxy failed ifFalse: [
		result := self cCode: 'snd_EnableAEC(trueOrFalse)'.
		result == 0 ifFalse: [interpreterProxy primitiveFailFor: result].
	].