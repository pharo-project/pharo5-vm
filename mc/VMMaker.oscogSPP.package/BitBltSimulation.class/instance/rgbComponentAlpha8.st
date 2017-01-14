combination rules
rgbComponentAlpha8
	"This version assumes 
		combinationRule = 41
		sourcePixSize = 32
		destPixSize = 8
		sourceForm ~= destForm.
	Note: This is not real blending since we don't have the source colors available.
	"
	
	| srcIndex dstIndex sourceWord srcAlpha destWord deltaX deltaY 
	srcY dstY dstMask srcShift adjust mappingTable mapperFlags |
	
	<inline: false>  "This particular method should be optimized in itself"
	<var: #mappingTable declareC:'unsigned int *mappingTable'>
	<var: #sourceWord type: #'unsigned int'>
	<var: #destWord type: #'unsigned int'>
	<var: #dstMask type: #'unsigned int'>
	
	mappingTable := self default8To32Table.
	mapperFlags := cmFlags bitAnd: ColorMapNewStyle bitInvert32.
	deltaY := bbH + 1. "So we can pre-decrement"
	srcY := sy.
	dstY := dy.
	mask1 := ((dx bitAnd: 3) * 8).
	destMSB ifTrue:[mask1 := 24 - mask1].
	mask2 := AllOnes bitXor:(16rFF << mask1).
	(dx bitAnd: 1) = 0 
		ifTrue:[adjust := 0]
		ifFalse:[adjust := 16r1F1F1F1F].
	(dy bitAnd: 1) = 0
		ifTrue:[adjust := adjust bitXor: 16r1F1F1F1F].
	"This is the outer loop"
	[(deltaY := deltaY - 1) ~= 0] whileTrue:[
		adjust := adjust bitXor: 16r1F1F1F1F.
		srcIndex := sourceBits + (srcY * sourcePitch) + (sx * 4).
		dstIndex := destBits + (dstY * destPitch) + (dx // 4 * 4).
		deltaX := bbW + 1. "So we can pre-decrement"
		srcShift := mask1.
		dstMask := mask2.

		"This is the inner loop"
		[(deltaX := deltaX - 1) ~= 0] whileTrue:[
			sourceWord := ((self srcLongAt: srcIndex) bitAnd: (adjust bitInvert32)) + adjust.
			srcAlpha := sourceWord bitAnd: 16rFFFFFF.
			"set srcAlpha to the average of the 3 separate aR,Ag,AB values"
			srcAlpha := ((srcAlpha >> 16) + (srcAlpha >> 8 bitAnd: 16rFF) + (srcAlpha bitAnd: 16rFF)) // 3.
			srcAlpha > 31 ifTrue:["Everything below 31 is transparent"
				srcAlpha > 224 
					ifTrue: ["treat everything above 224 as opaque"
						sourceWord := 16rFFFFFFFF].
				destWord := self dstLongAt: dstIndex.
				destWord := destWord bitAnd: dstMask bitInvert32.
				destWord := destWord >> srcShift.
				destWord := mappingTable at: destWord.
				sourceWord := self rgbComponentAlpha32: sourceWord with: destWord.
				sourceWord := self mapPixel: sourceWord flags: mapperFlags.
				sourceWord := sourceWord << srcShift.
				"Store back"
				self dstLongAt: dstIndex put: sourceWord mask: dstMask.
			].
			srcIndex := srcIndex + 4.
			destMSB ifTrue:[
				srcShift = 0 
					ifTrue:[dstIndex := dstIndex + 4.
							srcShift := 24.
							dstMask := 16r00FFFFFF]
					ifFalse:[srcShift := srcShift - 8.
							dstMask := (dstMask >> 8) bitOr: 16rFF000000].
			] ifFalse:[
				srcShift = 32
					ifTrue:[dstIndex := dstIndex + 4.
							srcShift := 0.
							dstMask := 16rFFFFFF00]
					ifFalse:[srcShift := srcShift + 8.
							dstMask := dstMask << 8 bitOr: 255].
			].
			adjust := adjust bitXor: 16r1F1F1F1F.
		].
		srcY := srcY + 1.
		dstY := dstY + 1.
	].
