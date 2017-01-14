primitives
primitiveSoundGetRecordingSampleRate
	"Return a float representing the actual sampling rate during recording. Fail if not currently recording."

	| rate |
	<var: #rate type: 'double '>
	self primitive: 'primitiveSoundGetRecordingSampleRate'.
	rate := self cCode: 'snd_GetRecordingSampleRate()'.  "fail if not recording"
	^rate asFloatObj