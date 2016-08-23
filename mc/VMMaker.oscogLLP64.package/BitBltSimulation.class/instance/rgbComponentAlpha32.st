combination rules
rgbComponentAlpha32
	"This version assumes 
		combinationRule = 41
		sourcePixSize = destPixSize = 32
		sourceForm ~= destForm.
	Note: The inner loop has been optimized for dealing
		with the special case of aR = aG = aB = 0 
	"
	| srcIndex dstIndex sourceWord srcAlpha destWord deltaX deltaY srcY dstY |

	<inline: false> "This particular method should be optimized in itself"

	"Give the compile a couple of hints"
	<var: #deltaX type: 'register sqInt'>
	<var: #sourceWord type: #'unsigned int'>
	<var: #destWord type: #'unsigned int'>

	"The following should be declared as pointers so the compiler will
	notice that they're used for accessing memory locations 
	(good to know on an Intel architecture) but then the increments
	would be different between ST code and C code so must hope the
	compiler notices what happens (MS Visual C does)"
	<var: #srcIndex type: 'register sqIntptr_t'>
	<var: #dstIndex type: 'register sqIntptr_t'>
	
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
			srcAlpha := sourceWord bitAnd:16rFFFFFF.
				srcAlpha = 0 ifTrue:[
					srcIndex := srcIndex + 4.
					dstIndex := dstIndex + 4.
					"Now skip as many words as possible,"
					[(deltaX := deltaX - 1) ~= 0 and:[
						((sourceWord := self srcLongAt: srcIndex) bitAnd:16rFFFFFF) = 0]]
						whileTrue:[
							srcIndex := srcIndex + 4.
							dstIndex := dstIndex + 4.
						].
					"Adjust deltaX"
					deltaX := deltaX + 1.
				] ifFalse:[ "0 < srcAlpha"
					"If we have to mix colors then just copy a single word"
					destWord := self dstLongAt: dstIndex.
					destWord := self rgbComponentAlpha32: sourceWord with: destWord.
					self dstLongAt: dstIndex put: destWord.
					srcIndex := srcIndex + 4.
					dstIndex := dstIndex + 4.
				].
		].
		srcY := srcY + 1.
		dstY := dstY + 1.
	].