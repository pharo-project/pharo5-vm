combination rules
rgbComponentAlpha16
	"This version assumes 
		combinationRule = 41
		sourcePixSize = 32
		destPixSize = 16
		sourceForm ~= destForm.
	"
	<inline: false>  "This particular method should be optimized in itself"
	<var: #sourceWord type: #'unsigned int'>
	<var: #destWord type: #'unsigned int'>
	<var: #dstMask type: #'unsigned int'>
	
	| srcIndex dstIndex sourceWord srcAlpha destWord deltaX deltaY 
	srcY dstY dstMask srcShift ditherBase ditherIndex ditherThreshold |

	deltaY := bbH + 1. "So we can pre-decrement"
	srcY := sy.
	dstY := dy.
	srcShift := (dx bitAnd: 1) * 16.
	destMSB ifTrue:[srcShift := 16 - srcShift].
	mask1 := 16rFFFF << (16 - srcShift).
	"This is the outer loop"
	[(deltaY := deltaY - 1) ~= 0] whileTrue:[
		srcIndex := sourceBits + (srcY * sourcePitch) + (sx * 4).
		dstIndex := destBits + (dstY * destPitch) + (dx // 2 * 4).
		ditherBase := (dstY bitAnd: 3) * 4.
		ditherIndex := (sx bitAnd: 3) - 1. "For pre-increment"
		deltaX := bbW + 1. "So we can pre-decrement"
		dstMask := mask1.
		dstMask = 16rFFFF ifTrue:[srcShift := 16] ifFalse:[srcShift := 0].

		"This is the inner loop"
		[(deltaX := deltaX - 1) ~= 0] whileTrue:[
			ditherThreshold := ditherMatrix4x4 at: ditherBase + (ditherIndex := ditherIndex + 1 bitAnd: 3).
			sourceWord := self srcLongAt: srcIndex.
			srcAlpha := sourceWord bitAnd: 16rFFFFFF.
				srcAlpha = 0 ifFalse:[ "0 < srcAlpha"
					"If we have to mix colors then just copy a single word"
					destWord := self dstLongAt: dstIndex.
					destWord := destWord bitAnd: dstMask bitInvert32.
					destWord := destWord >> srcShift.
					"Expand from 16 to 32 bit by adding zero bits"
					destWord := (((destWord bitAnd: 16r7C00) bitShift: 9) bitOr:
									((destWord bitAnd: 16r3E0) bitShift: 6)) bitOr:
								(((destWord bitAnd: 16r1F) bitShift: 3) bitOr:
									16rFF000000).
					"Mix colors"
					sourceWord := self rgbComponentAlpha32: sourceWord with: destWord.
					"And dither"
					sourceWord := self dither32To16: sourceWord threshold: ditherThreshold.
					sourceWord = 0 
						ifTrue:[sourceWord := 1 << srcShift]
						ifFalse:[sourceWord := sourceWord << srcShift].
					"Store back"
					self dstLongAt: dstIndex put: sourceWord mask: dstMask.
				].
			srcIndex := srcIndex + 4.
			destMSB
				ifTrue:[srcShift = 0 ifTrue:[dstIndex := dstIndex + 4]]
				ifFalse:[srcShift = 0 ifFalse:[dstIndex := dstIndex + 4]].
			srcShift := srcShift bitXor: 16. "Toggle between 0 and 16"
			dstMask := dstMask bitInvert32. "Mask other half word"
		].
		srcY := srcY + 1.
		dstY := dstY + 1.
	].
