primitives
primitiveSoundSetLeftVolume: aLeftVolume rightVolume: aRightVolume
	"Set the sound input recording level."

	self primitive: 'primitiveSoundSetLeftVolume'
		parameters: #(Float Float).
	interpreterProxy failed ifFalse: [self cCode: 'snd_SetVolume(aLeftVolume,aRightVolume)'].
