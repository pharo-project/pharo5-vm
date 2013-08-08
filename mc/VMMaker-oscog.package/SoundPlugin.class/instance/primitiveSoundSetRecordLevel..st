primitives
primitiveSoundSetRecordLevel: level 
	"Set the sound input recording level."
	self primitive: 'primitiveSoundSetRecordLevel'
		parameters: #(SmallInteger ).
	interpreterProxy failed ifFalse: [self cCode: 'snd_SetRecordLevel(level)']