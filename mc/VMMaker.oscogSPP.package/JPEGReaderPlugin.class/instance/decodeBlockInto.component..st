decoding
decodeBlockInto: anArray component: aColorComponent
	| byte zeroCount bits index |
	<var: #anArray type: 'int *'>
	<var: #aColorComponent type: 'int *'>
	byte := self jpegDecodeValueFrom: dcTable size: dcTableSize.
	byte < 0 ifTrue:[^interpreterProxy primitiveFail].
	byte ~= 0 ifTrue: [
		bits := self getBits: byte.
		byte := self scaleAndSignExtend: bits inFieldWidth: byte].
	byte := aColorComponent 
				at: PriorDCValueIndex 
				put: (aColorComponent at: PriorDCValueIndex) + byte.
	anArray at: 0 put: byte.
	1 to: DCTSize2 - 1 do:[:i| anArray at: i put: 0].
	index := 1.
	[index < DCTSize2] whileTrue:[
		byte := self jpegDecodeValueFrom: acTable size: acTableSize.
		byte < 0 ifTrue:[^interpreterProxy primitiveFail].
		zeroCount := byte >> 4.
		byte := byte bitAnd: 16r0F.
		byte ~= 0 ifTrue:[
			index := index + zeroCount.
			bits :=  self getBits: byte.
			byte := self scaleAndSignExtend: bits inFieldWidth: byte.
			(index < 0 or:[index >= DCTSize2]) ifTrue:[^interpreterProxy primitiveFail].
			anArray at:	 (jpegNaturalOrder at: index) put: byte.
		] ifFalse:[
			zeroCount = 15 ifTrue: [index := index + zeroCount] ifFalse: [^ nil].
		].
		index := index + 1
	].