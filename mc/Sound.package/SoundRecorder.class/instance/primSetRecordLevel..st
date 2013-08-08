primitives
primSetRecordLevel: anInteger
	"Set the desired recording level to the given value in the range 0-1000, where 0 is the lowest recording level and 1000 is the maximum. Do nothing if the sound input hardware does not support changing the recording level."

	<primitive: 'primitiveSoundSetRecordLevel' module: 'SoundPlugin'>
	self primitiveFailed
