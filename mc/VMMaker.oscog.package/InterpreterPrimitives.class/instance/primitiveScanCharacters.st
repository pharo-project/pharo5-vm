I/O primitives
primitiveScanCharacters
	"The character scanner primitive."
	| kernDelta stops sourceString scanStopIndex scanStartIndex rcvr scanDestX scanLastIndex scanXTable
	  scanMap maxGlyph ascii stopReason glyphIndex sourceX sourceX2 nextDestX scanRightX nilOop |

	self methodArgumentCount = 6
		ifFalse: [^ self primitiveFail].

	"Load the receiver and arguments"
	kernDelta := self stackIntegerValue: 0.
	stops := self stackValue: 1.
	scanRightX := self stackIntegerValue: 2.
	sourceString := self stackValue: 3.
	scanStopIndex := self stackIntegerValue: 4.
	scanStartIndex := self stackIntegerValue: 5.
	rcvr := self stackValue: 6.
	self successful ifFalse: [^ nil].
	
	"check argument type and range and rcvr"
	((objectMemory isArray: stops)
	 and: [(objectMemory slotSizeOf: stops) >= 258
	 and: [(objectMemory isBytes: sourceString)
	 and: [scanStartIndex > 0
	 and: [scanStopIndex > 0
	 and: [scanStopIndex <= (objectMemory byteSizeOf: sourceString)
	 and: [(objectMemory isPointers: rcvr)
	 and: [(objectMemory slotSizeOf: rcvr) >= 4]]]]]]])
		ifFalse: [^ self primitiveFail].

	"Check required rcvr instVars"
	scanDestX := self fetchInteger: 0 ofObject: rcvr.
	scanLastIndex := self fetchInteger: 1 ofObject: rcvr.
	scanXTable := objectMemory fetchPointer: 2 ofObject: rcvr.
	scanMap := objectMemory fetchPointer: 3 ofObject: rcvr.
	((objectMemory isArray: scanXTable)
	 and: [(objectMemory isArray: scanMap)
	 and: [(objectMemory slotSizeOf: scanMap) = 256
	 and: [self successful "for the fetchInteger:ofObject:'s abobve"]]]) ifFalse:
		[^ self primitiveFail].
	maxGlyph := (objectMemory slotSizeOf: scanXTable) - 2.

	"Okay, here we go. We have eliminated nearly all failure 
	conditions, to optimize the inner fetches."
	scanLastIndex := scanStartIndex.
	nilOop := objectMemory nilObject.
	[scanLastIndex <= scanStopIndex]
		whileTrue: [
			"Known to be okay since scanStartIndex > 0 and scanStopIndex <= sourceString size"
			ascii := objectMemory fetchByte: scanLastIndex - 1 ofObject: sourceString.
			"Known to be okay since stops size >= 258"
			(stopReason := objectMemory fetchPointer: ascii ofObject: stops) = nilOop
				ifFalse: ["Store everything back and get out of here since some stop conditionn needs to be checked"
					(objectMemory isIntegerValue: scanDestX) ifFalse: [^ self primitiveFail].
					self storeInteger: 0 ofObject: rcvr withValue: scanDestX.
					self storeInteger: 1 ofObject: rcvr withValue: scanLastIndex.
					self pop: 7. "args+rcvr"
					^ self push: stopReason].
			"Known to be okay since scanMap size = 256"
			glyphIndex := self fetchInteger: ascii ofObject: scanMap.
			"fail if the glyphIndex is out of range"
			(self failed or: [glyphIndex < 0 	or: [glyphIndex > maxGlyph]]) ifTrue: [^ self primitiveFail].
			sourceX := self fetchInteger: glyphIndex ofObject: scanXTable.
			sourceX2 := self fetchInteger: glyphIndex + 1 ofObject: scanXTable.
			"Above may fail if non-integer entries in scanXTable"
			self failed ifTrue: [^ nil].
			nextDestX := scanDestX + sourceX2 - sourceX.
			nextDestX > scanRightX ifTrue:
				["Store everything back and get out of here since we got to the right edge"
				(objectMemory isIntegerValue: scanDestX) ifFalse: [^ self primitiveFail].
				self storeInteger: 0 ofObject: rcvr withValue: scanDestX.
				self storeInteger: 1 ofObject: rcvr withValue: scanLastIndex.
				self pop: 7 "args+rcvr" thenPush: (objectMemory fetchPointer: CrossedX - 1 ofObject: stops).
				^nil].
			scanDestX := nextDestX + kernDelta.
			scanLastIndex := scanLastIndex + 1].
	(objectMemory isIntegerValue: scanDestX) ifFalse: [^ self primitiveFail].
	self storeInteger: 0 ofObject: rcvr withValue: scanDestX.
	self storeInteger: 1 ofObject: rcvr withValue: scanStopIndex.
	self pop: 7 "args+rcvr" thenPush: (objectMemory fetchPointer: EndOfRun - 1 ofObject: stops)