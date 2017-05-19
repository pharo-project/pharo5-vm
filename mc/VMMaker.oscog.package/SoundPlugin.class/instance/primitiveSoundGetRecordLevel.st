primitives
primitiveSoundGetRecordLevel
	"Get the sound input recording level  in the range 0-1000."
	| level |
	<var: 'level' type: #int>
	self primitive: 'primitiveSoundGetRecordLevel'.
	level := self cCode: 'snd_GetRecordLevel()'.
	^level asPositiveIntegerObj
