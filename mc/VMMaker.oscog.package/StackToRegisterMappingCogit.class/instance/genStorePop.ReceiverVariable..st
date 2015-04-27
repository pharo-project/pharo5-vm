bytecode generator support
genStorePop: popBoolean ReceiverVariable: slotIndex
	<inline: false>
	^ needsFrame 
		ifFalse: 
			[ self 
				genStorePop: popBoolean 
				ReceiverVariable: slotIndex 
				traceBlock: [ backEnd saveAndRestoreLinkRegAround: [self CallRT: ceTraceStoreTrampoline] ]
				inFrame: needsFrame ]
		ifTrue: 
			[ self 
				genStorePop: popBoolean 
				ReceiverVariable: slotIndex 
				traceBlock: [ self CallRT: ceTraceStoreTrampoline ]
				inFrame: needsFrame ]