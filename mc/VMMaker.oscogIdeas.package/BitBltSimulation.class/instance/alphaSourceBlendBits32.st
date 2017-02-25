inner loop
alphaSourceBlendBits32
	"This version assumes 
		combinationRule = 34
		sourcePixSize = destPixSize = 32
		sourceForm ~= destForm.
	Note: The inner loop has been optimized for dealing
		with the special cases of srcAlpha = 0.0 and srcAlpha = 1.0 
	"
	| srcIndex dstIndex sourceWord srcAlpha destWord deltaX deltaY srcY dstY |
	<inline: false> "This particular method should be optimized in itself"
	<var: #sourceWord type: #'unsigned int'>
	<var: #destWord type: #'unsigned int'>

	"Give the compile a couple of hints"

	"The following should be declared as pointers so the compiler will
	notice that they're used for accessing memory locations 
	(good to know on an Intel architecture) but then the increments
	would be different between ST code and C code so must hope the
	compiler notices what happens (MS Visual C does)"

	deltaY := bbH + 1. "So we can pre-decrement"
	srcY := sy.
	dstY := dy.

	"This is the outer loop"
	[(deltaY := deltaY - 1) ~= 0] whileTrue:[
		srcIndex := sourceBits + (srcY * sourcePitch) + (sx * 4).
		dstIndex := destBits + (dstY * destPitch) + (dx * 4).
		deltaX := bbW + 1. "So we can pre-decrement"

		"This is the inner loop"
		[(deltaX := deltaX - 1) ~= 0] whileTrue:[
			sourceWord := self srcLongAt: srcIndex.
			srcAlpha := sourceWord >> 24.
			srcAlpha = 255 ifTrue:[
				self dstLongAt: dstIndex put: sourceWord.
				srcIndex := srcIndex + 4.
				dstIndex := dstIndex + 4.
				"Now copy as many words as possible with alpha = 255"
				[(deltaX := deltaX - 1) ~= 0 and:[
					(sourceWord := self srcLongAt: srcIndex) >> 24 = 255]]
						whileTrue:[
							self dstLongAt: dstIndex put: sourceWord.
							srcIndex := srcIndex + 4.
							dstIndex := dstIndex + 4.
						].
				"Adjust deltaX"
				deltaX := deltaX + 1.
			] ifFalse:[ "srcAlpha ~= 255"
				srcAlpha = 0 ifTrue:[
					srcIndex := srcIndex + 4.
					dstIndex := dstIndex + 4.
					"Now skip as many words as possible,"
					[(deltaX := deltaX - 1) ~= 0 and:[
						(sourceWord := self srcLongAt: srcIndex) >> 24 = 0]]
						whileTrue:[
							srcIndex := srcIndex + 4.
							dstIndex := dstIndex + 4.
						].
					"Adjust deltaX"
					deltaX := deltaX + 1.
				] ifFalse:[ "0 < srcAlpha < 255"
					"If we have to mix colors then just copy a single word"
					destWord := self dstLongAt: dstIndex.
					destWord := self alphaBlendScaled: sourceWord with: destWord.
					self dstLongAt: dstIndex put: destWord.
					srcIndex := srcIndex + 4.
					dstIndex := dstIndex + 4.
				].
			].
		].
		srcY := srcY + 1.
		dstY := dstY + 1.
	].