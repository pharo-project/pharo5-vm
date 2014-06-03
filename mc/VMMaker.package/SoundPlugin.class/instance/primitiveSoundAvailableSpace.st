primitives
primitiveSoundAvailableSpace
	"Returns the number of bytes of available sound output buffer space.  This should be (frames*4) if the device is in stereo mode, or (frames*2) otherwise"

	| frames |
	self primitive: 'primitiveSoundAvailableSpace'.
	frames := self cCode: 'snd_AvailableSpace()'.  "-1 if sound output not started"
	interpreterProxy success: frames >= 0.
	^frames asPositiveIntegerObj