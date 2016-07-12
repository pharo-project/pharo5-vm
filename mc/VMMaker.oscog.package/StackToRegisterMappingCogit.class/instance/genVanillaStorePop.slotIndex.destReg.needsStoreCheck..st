bytecode generator support
genVanillaStorePop: popBoolean slotIndex: slotIndex destReg: destReg needsStoreCheck: needsStoreCheck
	<inline: true>
	| topReg |

	self deny: (needsStoreCheck and: [self ssTopNeedsStoreCheck not]).
	self cppIf: IMMUTABILITY
		ifTrue: []
		ifFalse: "First path, receiver is in newSpace"
			[(destReg = ReceiverResultReg and: [needsFrame not and: [useTwoPaths]]) ifTrue:
				[topReg := self ssStorePop: popBoolean toPreferredReg: TempReg.
				 self MoveR: topReg
					Mw: slotIndex * objectMemory wordSize + objectMemory baseHeaderSize
					r: ReceiverResultReg.
				 traceStores > 0 ifTrue:
					[topReg ~= TempReg ifTrue:
						[self MoveR: topReg R: TempReg].
					 self CallRT: ceTraceStoreTrampoline].
				 ^0]].
	topReg := self 
				allocateRegForStackEntryAt: 0 
				notConflictingWith: (self registerMaskFor: destReg). 
	self ssStorePop: popBoolean toReg: topReg.
	objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: slotIndex
		destReg: destReg
		scratchReg: TempReg
		inFrame: needsFrame
		needsStoreCheck: needsStoreCheck