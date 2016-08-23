combination rules
OLDtallyIntoMap: sourceWord with: destinationWord
	"Tally pixels into the color map.  Note that the source should be 
	specified = destination, in order for the proper color map checks 
	to be performed at setup.
	Note that the region is not clipped to bit boundaries, but only to the
	nearest (enclosing) word.  This is because copyLoop does not do
	pre-merge masking.  For accurate results, you must subtract the
	values obtained from the left and right fringes."
	| mapIndex pixMask shiftWord |
	(cmFlags bitAnd: (ColorMapPresent bitOr: ColorMapIndexedPart)) =
		(ColorMapPresent bitOr: ColorMapIndexedPart)
			ifFalse: [^ destinationWord "no op"].
	destDepth < 16 ifTrue:
		["loop through all packed pixels."
		pixMask := (maskTable at: destDepth) bitAnd: cmMask.
		shiftWord := destinationWord.
		1 to: destPPW do:
			[:i |
			mapIndex := shiftWord bitAnd: pixMask.
			self tallyMapAt: mapIndex put: (self tallyMapAt: mapIndex) + 1.
			shiftWord := shiftWord >> destDepth].
		^ destinationWord].
	destDepth = 16 ifTrue:
		["Two pixels  Tally the right half..."
		mapIndex := self rgbMap: (destinationWord bitAnd: 16rFFFF) from: 5 to: cmBitsPerColor.
		self tallyMapAt: mapIndex put: (self tallyMapAt: mapIndex) + 1.
		"... and then left half"
		mapIndex := self rgbMap: destinationWord>>16 from: 5 to: cmBitsPerColor.
		self tallyMapAt: mapIndex put: (self tallyMapAt: mapIndex) + 1]
	ifFalse:
		["Just one pixel."
		mapIndex := self rgbMap: destinationWord from: 8 to: cmBitsPerColor.
		self tallyMapAt: mapIndex put: (self tallyMapAt: mapIndex) + 1].
	^ destinationWord  "For no effect on dest"