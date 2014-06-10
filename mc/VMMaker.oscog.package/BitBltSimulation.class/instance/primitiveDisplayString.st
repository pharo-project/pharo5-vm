primitives
primitiveDisplayString

	| kernDelta xTable glyphMap stopIndex startIndex sourceString bbObj maxGlyph ascii glyphIndex sourcePtr left quickBlt |
	<export: true>
	<var: #sourcePtr type: 'char *'>
	interpreterProxy methodArgumentCount = 6 
		ifFalse:[^interpreterProxy primitiveFail].
	kernDelta := interpreterProxy stackIntegerValue: 0.
	xTable := interpreterProxy stackObjectValue: 1.
	glyphMap := interpreterProxy stackObjectValue: 2.
	((interpreterProxy fetchClassOf: xTable) = interpreterProxy classArray and:[
		(interpreterProxy fetchClassOf: glyphMap) = interpreterProxy classArray])
			ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy slotSizeOf: glyphMap) = 256 ifFalse:[^interpreterProxy primitiveFail].
	interpreterProxy failed ifTrue:[^nil].
	maxGlyph := (interpreterProxy slotSizeOf: xTable) - 2.

	stopIndex := interpreterProxy stackIntegerValue: 3.
	startIndex := interpreterProxy stackIntegerValue: 4.
	sourceString := interpreterProxy stackObjectValue: 5.
	(interpreterProxy isBytes: sourceString) ifFalse:[^interpreterProxy primitiveFail].
	(startIndex > 0 and:[stopIndex > 0 and:[
		stopIndex <= (interpreterProxy byteSizeOf: sourceString)]])
			ifFalse:[^interpreterProxy primitiveFail].

	bbObj := interpreterProxy stackObjectValue: 6.
	(self loadBitBltFrom: bbObj) ifFalse:[^interpreterProxy primitiveFail].
	(combinationRule = 30 or:[combinationRule = 31]) "needs extra source alpha"
		ifTrue:[^interpreterProxy primitiveFail].
	"See if we can go directly into copyLoopPixMap (usually we can)"
	quickBlt := destBits ~= 0 "no OS surfaces please"
				and:[sourceBits ~= 0 "and again"
				and:[noSource = false "needs a source"
				and:[sourceForm ~= destForm "no blits onto self"
				and:[(cmFlags ~= 0 
						or:[sourceMSB ~= destMSB 
						or:[sourceDepth ~= destDepth]]) "no point using slower version"
				]]]].
	left := destX.
	sourcePtr := interpreterProxy firstIndexableField: sourceString.
	startIndex to: stopIndex do:[:charIndex|
		ascii := interpreterProxy byteAtPointer: sourcePtr + charIndex - 1.
		glyphIndex := interpreterProxy fetchInteger: ascii ofObject: glyphMap.
		(glyphIndex < 0 or:[glyphIndex > maxGlyph]) 
			ifTrue:[^interpreterProxy primitiveFail].
		sourceX := interpreterProxy fetchInteger: glyphIndex ofObject: xTable.
		width := (interpreterProxy fetchInteger: glyphIndex+1 ofObject: xTable) - sourceX.
		interpreterProxy failed ifTrue:[^nil].
		self clipRange.	"Must clip here"
		(bbW > 0 and:[bbH > 0]) ifTrue: [
			quickBlt ifTrue:[
				self destMaskAndPointerInit.
				self copyLoopPixMap.
				"both, hDir and vDir are known to be > 0"
				affectedL := dx.
				affectedR := dx + bbW.
				affectedT := dy.
				affectedB := dy + bbH.
			] ifFalse:[self copyBits]].
		interpreterProxy failed ifTrue:[^nil].
		destX := destX + width + kernDelta.
	 ].
	affectedL := left.
	self showDisplayBits.
	"store destX back"	
	interpreterProxy storeInteger: BBDestXIndex ofObject: bbObj withValue: destX.
	interpreterProxy pop: 6. "pop args, return rcvr"