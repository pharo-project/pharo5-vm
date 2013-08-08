interpreter interface
loadColorMapShiftOrMaskFrom: mapOop
	<returnTypeC: 'void *'>
	mapOop = interpreterProxy nilObject ifTrue:[^nil].
	(interpreterProxy isIntegerObject: mapOop) 
		ifTrue:[interpreterProxy primitiveFail. ^nil].
	((interpreterProxy isWords: mapOop) 
		and:[(interpreterProxy slotSizeOf: mapOop) = 4])
			ifFalse:[interpreterProxy primitiveFail. ^nil].
	^interpreterProxy firstIndexableField: mapOop