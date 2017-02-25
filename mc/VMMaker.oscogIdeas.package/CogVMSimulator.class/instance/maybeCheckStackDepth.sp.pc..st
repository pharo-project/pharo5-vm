debug support
maybeCheckStackDepth: delta sp: sp pc: mcpc
	| asp bcpc startbcpc cogHomeMethod cogBlockMethod csp debugStackPointers |
	debugStackDepthDictionary ifNil: [^self].
	(self isMachineCodeFrame: framePointer) ifFalse: [^self].
	cogBlockMethod := self mframeCogMethod: framePointer.
	cogHomeMethod := self asCogHomeMethod: cogBlockMethod.
	debugStackPointers := debugStackDepthDictionary
								at: cogHomeMethod methodObject
								ifAbsentPut: [self debugStackPointersFor: cogHomeMethod methodObject].
	startbcpc := cogHomeMethod = cogBlockMethod
					ifTrue: [self startPCOfMethod: cogHomeMethod methodObject]
					ifFalse: [self startPCOfClosure: (self pushedReceiverOrClosureOfFrame: framePointer)].
	bcpc := cogit bytecodePCFor: mcpc startBcpc: startbcpc in: cogBlockMethod.
	self assert: bcpc ~= 0.
	((cogBlockMethod ~= cogHomeMethod or: [cogBlockMethod cmIsFullBlock])
	 and: [cogit isNonLocalReturnPC: mcpc]) ifTrue:
		[| lastbcpc |
		 "Method returns within a block (within an unwind-protect) must check the stack depth at the
		  return, not the bytecode following, but the pc mapping maps to the bytecode following the
		  return. lastBytecodePCForBlockAt:in: catches method returns at the end of a block, modifying
		  the bcpc to that of the return.  isNonLocalReturnPC: catches method returns not at the end.
		  Assumes method return bytecodes are 1 bytecode long;a  dodgy assumption, but good enough."
		 lastbcpc := cogBlockMethod cmIsFullBlock
						ifTrue: [cogit endPCOf: cogHomeMethod methodObject]
						ifFalse: [cogit lastBytecodePCForBlockAt: startbcpc in: cogHomeMethod methodObject].
		 bcpc := bcpc > lastbcpc ifTrue: [lastbcpc] ifFalse: [bcpc - 1]].
	asp := self stackPointerIndexForFrame: framePointer WithSP: sp + objectMemory wordSize.
	csp := debugStackPointers at: bcpc ifAbsent: [-1].
	"Compensate for some edge cases"
	asp - delta = csp ifTrue:
		["Compensate for the implicit context receiver push in a trap bytecode with the absence of a contnuation.
		  Assumes trap bytecodes are 1 byte bytecodes."
		 (SistaVM
		  and: [cogit isTrapAt: mcpc]) ifTrue:
			[csp := csp + 1].
		"Compensate lazily for absent receiver sends (cuz mapping is slow, even though incrememting csp is a dodgy idea)."
		(NewspeakVM
		 and: [cogit isAbsentReceiverSendAt: mcpc in: cogHomeMethod]) ifTrue:
			[csp := debugStackPointers at: bcpc put: csp + 1]].
	self assert: asp - delta + 1 = csp