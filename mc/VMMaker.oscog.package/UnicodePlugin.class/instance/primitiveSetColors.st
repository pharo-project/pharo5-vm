primitives
primitiveSetColors

	| fgRed fgGreen fgBlue bgRed bgGreen bgBlue mapBGToTransparent |
	<export: true>

	fgRed := interpreterProxy stackIntegerValue: 6.
	fgGreen := interpreterProxy stackIntegerValue: 5.
	fgBlue := interpreterProxy stackIntegerValue: 4.
	bgRed := interpreterProxy stackIntegerValue: 3.
	bgGreen := interpreterProxy stackIntegerValue: 2.
	bgBlue := interpreterProxy stackIntegerValue: 1.
	mapBGToTransparent := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed ifTrue: [^ nil].

	self cCode: 'unicodeSetColors(fgRed, fgGreen, fgBlue, bgRed, bgGreen, bgBlue, mapBGToTransparent)'.

	interpreterProxy pop: 7.
	^ 0
