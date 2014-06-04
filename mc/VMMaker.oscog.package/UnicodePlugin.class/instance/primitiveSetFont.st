primitives
primitiveSetFont

	| fontName fontSize boldFlag italicFlag antiAliasFlag |
	<export: true>
	<var: 'fontName' declareC: 'char fontName[200]'>

	self copyString: (interpreterProxy stackValue: 4) into: fontName max: 200.
	fontSize := interpreterProxy stackIntegerValue: 3.
	boldFlag := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 2).
	italicFlag := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 1).
	antiAliasFlag := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed ifTrue: [^ nil].

	self cCode: 'unicodeSetFont(fontName, fontSize, boldFlag, italicFlag, antiAliasFlag)'.

	interpreterProxy pop: 5.
	^ 0
