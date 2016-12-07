simulation only
printSimStack: aSimStack toDepth: limit spillBase: spillBase on: aStream
	<doNotGenerate>
	| tempNamesOrNil width tabWidth |
	aStream ensureCr.
	limit < 0 ifTrue:
		[^aStream nextPutAll: 'simStackEmpty'; cr; flush].
	inBlock ~~ true ifTrue:
		[(tempNamesOrNil := self class initializationOptions at: #tempNames ifAbsent: [#()]) isEmpty ifFalse:
			[| tab longest |
			 longest := tempNamesOrNil inject: '' into: [:m :t| m size >= t size ifTrue: [m] ifFalse: [t]].
			 tabWidth := self widthInDefaultFontOf: (tab := String with: Character tab).
			 width := self widthInDefaultFontOf: longest, tab.
			 width <= ((self widthInDefaultFontOf: longest, (String with: Character space)) + 4) ifTrue:
				[width := width + tabWidth]]].
	0 to: limit do:
		[:i|
		width ifNotNil:
			[self put: (tempNamesOrNil at: i + 1 ifAbsent: ['']) paddedTo: width tabWidth: tabWidth on: aStream].
		aStream print: i.
		i = spillBase
			ifTrue: [aStream nextPutAll: ' sb'; tab]
			ifFalse: [aStream tab; tab].
		(aSimStack at: i) printStateOn: aStream.
		aStream cr; flush]