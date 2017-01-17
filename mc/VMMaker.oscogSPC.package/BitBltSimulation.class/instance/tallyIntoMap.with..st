combination rules
tallyIntoMap: sourceWord with: destinationWord
	"Tally pixels into the color map.  Those tallied are exactly those
	in the destination rectangle.  Note that the source should be 
	specified == destination, in order for the proper color map checks 
	to be performed at setup."
	| mapIndex pixMask destShifted maskShifted pixVal |
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	<var: #pixMask type: 'unsigned int'>
	<var: #destShifted type: 'unsigned int'>
	<var: #maskShifted type: 'unsigned int'>
	(cmFlags bitAnd: (ColorMapPresent bitOr: ColorMapIndexedPart)) = 
		(ColorMapPresent bitOr: ColorMapIndexedPart)
			ifFalse: [^ destinationWord "no op"].
	pixMask := maskTable at: destDepth.
	destShifted := destinationWord.
	maskShifted := destMask.
	1 to: destPPW do:
		[:i |
		(maskShifted bitAnd: pixMask) = 0 ifFalse:
			["Only tally pixels within the destination rectangle"
			pixVal := destShifted bitAnd: pixMask.
			destDepth < 16
				ifTrue: [mapIndex := pixVal]
				ifFalse: [destDepth = 16
					ifTrue: [mapIndex := self rgbMap: pixVal from: 5 to: cmBitsPerColor]
					ifFalse: [mapIndex := self rgbMap: pixVal from: 8 to: cmBitsPerColor]].
			self tallyMapAt: mapIndex put: (self tallyMapAt: mapIndex) + 1].
		maskShifted := maskShifted >> destDepth.
		destShifted := destShifted >> destDepth].
	^ destinationWord  "For no effect on dest"