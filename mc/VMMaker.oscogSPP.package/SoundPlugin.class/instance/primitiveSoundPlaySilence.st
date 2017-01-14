primitives
primitiveSoundPlaySilence
	"Output a buffer's worth of silence. Returns the number of sample frames played."

	| framesPlayed |
	self primitive: 'primitiveSoundPlaySilence'.
	framesPlayed := self cCode: 'snd_PlaySilence()'.  "-1 if sound output not started"
	interpreterProxy success: framesPlayed >= 0.
	^framesPlayed asPositiveIntegerObj