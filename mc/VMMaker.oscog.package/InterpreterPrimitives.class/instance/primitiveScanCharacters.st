I/O primitives
primitiveScanCharacters
	"The character scanner primitive."
	| kernDelta stops sourceString scanStopIndex scanStartIndex rcvr scanDestX scanLastIndex scanXTable scanMap maxGlyph ascii stopReason glyphIndex sourceX sourceX2 nextDestX scanRightX nilOop |

	self methodArgumentCount = 6
		ifFalse: [^ self primitiveFail].

	"Load the arguments"
	kernDelta := self stackIntegerValue: 0.
	stops := self stackObjectValue: 1.
	(objectMemory isArray: stops) ifFalse: [^ self primitiveFail].
	(objectMemory slotSizeOf: stops) >= 258 ifFalse: [^ self primitiveFail].
	scanRightX := self stackIntegerValue: 2.
	sourceString := self stackObjectValue: 3.
	(objectMemory isBytes: sourceString) ifFalse: [^ self primitiveFail].
	scanStopIndex := self stackIntegerValue: 4.
	scanStartIndex := self stackIntegerValue: 5.
	(scanStartIndex > 0 and: [scanStopIndex > 0 and: [scanStopIndex <= (objectMemory byteSizeOf: sourceString)]])
		ifFalse: [^ self primitiveFail].

	"Load receiver and required instVars"
	rcvr := self stackObjectValue: 6.
	((objectMemory isPointers: rcvr) and: [(objectMemory slotSizeOf: rcvr) >= 4]) ifFalse: [^ self primitiveFail].
	scanDestX := self fetchInteger: 0 ofObject: rcvr.
	scanLastIndex := self fetchInteger: 1 ofObject: rcvr.
	scanXTable := objectMemory fetchPointer: 2 ofObject: rcvr.
	scanMap := objectMemory fetchPointer: 3 ofObject: rcvr.
	((objectMemory isArray: scanXTable) and: [objectMemory isArray: scanMap]) ifFalse: [^ self primitiveFail].
	(objectMemory slotSizeOf: scanMap) = 256 ifFalse: [^ self primitiveFail].
	self successful ifFalse: [^ nil].
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