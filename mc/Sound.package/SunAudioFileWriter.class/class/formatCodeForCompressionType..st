sound storing
formatCodeForCompressionType: aString
	"Answer the Sun audio file format number for the given compression type name."

	| lowercase |
	lowercase := aString asLowercase.
	'mulaw' = lowercase ifTrue: [^ 1].
	'none' = lowercase ifTrue: [^ 3].
	'adpcm3' = lowercase ifTrue: [^ 25].
	'adpcm4' = lowercase ifTrue: [^ 23].
	'adpcm5' = lowercase ifTrue: [^ 26].
	'gsm' = lowercase ifTrue: [^ 610].
	self error: 'unknown compression style'
