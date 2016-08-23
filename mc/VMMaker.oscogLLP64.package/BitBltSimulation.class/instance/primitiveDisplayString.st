primitives
primitiveDisplayString

	| kernDelta xTable glyphMap stopIndex startIndex sourceString bbObj maxGlyph ascii glyphIndex sourcePtr left quickBlt |
	<export: true>
	<var: #sourcePtr type: 'char *'>
	interpreterProxy methodArgumentCount = 6 ifFalse:
		[^interpreterProxy primitiveFail].
	kernDelta := interpreterProxy stackIntegerValue: 0.
	xTable := interpreterProxy stackObjectValue: 1.
	glyphMap := interpreterProxy stackObjectValue: 2.
	stopIndex := interpreterProxy stackIntegerValue: 3.
	startIndex := interpreterProxy stackIntegerValue: 4.
	sourceString := interpreterProxy stackObjectValue: 5.
	bbObj := interpreterProxy stackObjectValue: 6.
	interpreterProxy failed ifTrue:
		[^nil].

	((interpreterProxy isArray: xTable)
	 and: [(interpreterProxy isArray: glyphMap)
	 and: [(interpreterProxy slotSizeOf: glyphMap) = 256
	 and: [(interpreterProxy isBytes: sourceString)
	 and: [startIndex > 0
	 and: [stopIndex > 0
	 and: [stopIndex <= (interpreterProxy byteSizeOf: sourceString)
	 and: [(self loadBitBltFrom: bbObj)
	 and: [combinationRule ~= 30 "these two need extra source alpha"
	 and: [combinationRule ~= 31]]]]]]]]]) ifFalse:
		[^interpreterProxy primitiveFail].
	maxGlyph := (interpreterProxy slotSizeOf: xTable) - 2.
	"See if we can go directly into copyLoopPixMap (usually we can)"
	quickBlt := destBits ~= 0 "no OS surfaces please"
				and:[sourceBits ~= 0 "and again"
				and:[noSource = false "needs a source"
				and:[sourceForm ~= destForm "no blits onto self"
				and:[cmFlags ~= 0 
					 or:[sourceMSB ~= destMSB 
					 or:[sourceDepth ~= destDepth]]]]]]. "no point using slower version"
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