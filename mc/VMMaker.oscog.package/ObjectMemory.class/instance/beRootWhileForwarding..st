gc -- compaction
beRootWhileForwarding: oop
	"Record that the given oop in the old object area points to an object in the young area when oop may be forwarded."
	"Warning: No young objects should be recorded as roots. Callers are responsible for ensuring this constraint is not violated."
	<inline: false> "for debugging..."
	| header fwdBlock headerLoc |
	"If labelled, gcc duplicates the label when inlining updatePointersInRangeFrom:to:"
	header := self longAt: oop.
	(header bitAnd: MarkBit) ~= 0
		ifTrue: "This oop is forwarded"
			[fwdBlock := (header bitAnd: AllButMarkBitAndTypeMask) << 1.
			self assert: (self fwdBlockValid: fwdBlock).
			headerLoc := fwdBlock + self wordSize]
		ifFalse: "Normal -- no forwarding"
			[headerLoc := oop].
	"use headerLoc var to eliminate duplication on inlining noteAsRoot:headerLoc:
	 older versions of this method had two separate sends of noteAsRoot:headerLoc:"
	self noteAsRoot: oop headerLoc: headerLoc