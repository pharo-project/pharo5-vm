generate machine code
fillInBlockHeadersAt: startAddress
	"Fill in the block headers now we know the exact layout of the code."
	| blockStart blockHeader |
	<var: #blockStart type: #'BlockStart *'>
	<var: #blockHeader type: #'CogBlockMethod *'>

	(needsFrame and: [blockCount > 0]) ifFalse:
		[^nil].
	blockNoContextSwitchOffset = nil
		ifTrue: [blockNoContextSwitchOffset := blockEntryLabel address - blockEntryNoContextSwitch address]
		ifFalse: [self assert: blockNoContextSwitchOffset = (blockEntryLabel address - blockEntryNoContextSwitch address)].
	0 to: blockCount - 1 do:
		[:i|
		blockStart := self blockStartAt: i.
		blockHeader := self cCoerceSimple: blockStart fakeHeader address
								to: #'CogBlockMethod *'.
		blockHeader
			homeOffset: (blockStart fakeHeader address - startAddress);
			startpc: blockStart startpc;
			cmType: CMBlock;
			cmNumArgs: blockStart numArgs;
			cbUsesInstVars: blockStart hasInstVarRef;
			stackCheckOffset: (blockStart stackCheckLabel = nil
								ifTrue: [0]
								ifFalse: [blockStart stackCheckLabel address - blockStart fakeHeader address])]