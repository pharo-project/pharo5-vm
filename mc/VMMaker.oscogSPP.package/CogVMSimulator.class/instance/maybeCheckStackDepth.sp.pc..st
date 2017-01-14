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
	cogBlockMethod ~= cogHomeMethod ifTrue:
		[| lastbcpc |
		 lastbcpc := cogit lastBytecodePCForBlockAt: startbcpc in: cogHomeMethod methodObject.
		 bcpc > lastbcpc ifTrue:
			[bcpc := lastbcpc]].
	asp := self stackPointerIndexForFrame: framePointer WithSP: sp + objectMemory wordSize.
	csp := debugStackPointers at: bcpc ifAbsent: [-1].
	"Compensate lazily for absent receiver sends."
	(NewspeakVM
	 and: [asp - delta = csp
	 and: [cogit isAbsentReceiverSendAt: mcpc in: cogHomeMethod]]) ifTrue:
		[csp := debugStackPointers at: bcpc put: csp + 1].
	self assert: asp - delta + 1 = csp