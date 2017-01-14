setup
copyBitsLockedAndClipped
	"Perform the actual copyBits operation.
	Assume: Surfaces have been locked and clipping was performed."
	| done |
	<inline: false>
	
	self copyBitsRule41Test.	
	(interpreterProxy failed not)
		ifFalse: [^ interpreterProxy primitiveFail].

 	"Try a shortcut for stuff that should be run as quickly as possible"
	done := self tryCopyingBitsQuickly.
	done ifTrue:[^nil].

	(combinationRule = 30) | (combinationRule = 31) ifTrue:
		["Check and fetch source alpha parameter for alpha blend"
		interpreterProxy methodArgumentCount = 1
			ifTrue: [sourceAlpha := interpreterProxy stackIntegerValue: 0.
					(interpreterProxy failed not and: [(sourceAlpha >= 0) & (sourceAlpha <= 255)])
						ifFalse: [^ interpreterProxy primitiveFail]]
			ifFalse: [^ interpreterProxy primitiveFail]].

	bitCount := 0.
	"Choose and perform the actual copy loop."
	self performCopyLoop.

	(combinationRule = 22) | (combinationRule = 32) ifTrue:
		["zero width and height; return the count"
		affectedL := affectedR := affectedT := affectedB := 0]. 
	hDir > 0
		ifTrue: [affectedL := dx.
				affectedR := dx + bbW]
		ifFalse: [affectedL := dx - bbW + 1.
				affectedR := dx + 1].
	vDir > 0
		ifTrue: [affectedT := dy.
				affectedB := dy + bbH]
		ifFalse: [affectedT := dy - bbH + 1.
				affectedB := dy + 1]