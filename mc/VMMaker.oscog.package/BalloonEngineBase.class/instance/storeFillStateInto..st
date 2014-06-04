storing state
storeFillStateInto: fillOop
	| fillIndex leftX rightX |
	<inline: false>
	fillIndex := self lastExportedFillGet.
	leftX := self lastExportedLeftXGet.
	rightX := self lastExportedRightXGet.

	(interpreterProxy slotSizeOf: fillOop) < FTBalloonFillDataSize 
		ifTrue:[^interpreterProxy primitiveFail].
	interpreterProxy storeInteger: FTIndexIndex ofObject: fillOop withValue: 
		(self objectIndexOf: fillIndex).
	interpreterProxy storeInteger: FTMinXIndex ofObject: fillOop withValue: leftX.
	interpreterProxy storeInteger: FTMaxXIndex ofObject: fillOop withValue: rightX.
	interpreterProxy storeInteger: FTYValueIndex ofObject: fillOop withValue: self currentYGet.