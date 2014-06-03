decoding
colorComponent: aColorComponent from: oop
	<var: #aColorComponent type: 'int *'>
	(interpreterProxy isPointers: oop) ifFalse:[^false].
	(interpreterProxy slotSizeOf: oop) < MinComponentSize ifTrue:[^false].
	aColorComponent at: CurrentXIndex put: 
		(interpreterProxy fetchInteger: CurrentXIndex ofObject: oop).
	aColorComponent at: CurrentYIndex put: 
		(interpreterProxy fetchInteger: CurrentYIndex ofObject: oop).
	aColorComponent at: HScaleIndex put: 
		(interpreterProxy fetchInteger: HScaleIndex ofObject: oop).
	aColorComponent at: VScaleIndex put: 
		(interpreterProxy fetchInteger: VScaleIndex ofObject: oop).
	aColorComponent at: BlockWidthIndex put: 
		(interpreterProxy fetchInteger: BlockWidthIndex ofObject: oop).
	aColorComponent at: MCUWidthIndex put: 
		(interpreterProxy fetchInteger: MCUWidthIndex ofObject: oop).
	aColorComponent at: PriorDCValueIndex put: 
		(interpreterProxy fetchInteger: PriorDCValueIndex ofObject: oop).
	^interpreterProxy failed not