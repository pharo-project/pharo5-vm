compile abstract instructions
addBlockStartAt: bcpc numArgs: numArgs numCopied: numCopied span: span
	"Add a blockStart for an embedded block.  For a binary tree walk block dispatch
	 blocks must be compiled in pc/depth-first order but are scanned in breadth-first
	 order, so do an insertion sort (which of course is really a bubble sort because we
	 have to move everything higher to make room)."
	<returnTypeC: #'BlockStart *'>
	| i blockStart |
	<var: #blockStart type: #'BlockStart *'>
	blockCount > 0
		ifTrue:
			[i := blockCount - 1.
			 [blockStart := self addressOf: (blockStarts at: i).
			   blockStart startpc > bcpc
			   and: [i > 0]] whileTrue:
				[i := i - 1].
			 blockCount to: i + 1 by: -1 do:
				[:j|
				blockStarts at: j put: (blockStarts at: j - 1)].
			blockStart := self cCode: [self addressOf: (blockStarts at: i + 1)]
								inSmalltalk: [blockStarts at: i + 1 put: CogBlockStart new]]
		ifFalse:
			[blockStart := self cCode: [self addressOf: (blockStarts at: blockCount)]
								inSmalltalk: [blockStarts at: blockCount put: CogBlockStart new]].
	blockCount := blockCount + 1.
	blockStart
		startpc: bcpc;
		numArgs: numArgs;
		numCopied: numCopied;
		stackCheckLabel: nil;
		hasInstVarRef: false;
		span: span.
	^blockStart