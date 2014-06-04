setup
ignoreSourceOrHalftone: formPointer

	formPointer = interpreterProxy nilObject ifTrue: [ ^true ].
	combinationRule = 0 ifTrue: [ ^true ].
	combinationRule = 5 ifTrue: [ ^true ].
	combinationRule = 10 ifTrue: [ ^true ].
	combinationRule = 15 ifTrue: [ ^true ].
	^false