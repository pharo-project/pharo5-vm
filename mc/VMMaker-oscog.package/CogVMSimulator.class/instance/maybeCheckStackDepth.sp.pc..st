debug support
maybeCheckStackDepth: delta sp: sp pc: mcpc
	| asp bcpc cogHomeMethod cogBlockMethod csp debugStackPointers |
	debugStackDepthDictionary ifNil: [^self].
	(self isMachineCodeFrame: framePointer) ifFalse: [^self].
	cogBlockMethod := self mframeCogMethod: framePointer.
	cogHomeMethod := self asCogHomeMethod: cogBlockMethod.
	debugStackPointers := debugStackDepthDictionary
								at: cogHomeMethod methodObject
								ifAbsentPut: [self debugStackPointersFor: cogHomeMethod methodObject].
	bcpc := cogit
				bytecodePCFor: mcpc
				startBcpc: (cogHomeMethod = cogBlockMethod
								ifTrue: [self startPCOfMethod: cogHomeMethod methodObject]
								ifFalse: [self startPCOfClosure: (self pushedReceiverOrClosureOfFrame: framePointer)])
				in: cogBlockMethod.
	self assert: bcpc ~= 0.
	asp := self stackPointerIndexForFrame: framePointer WithSP: sp + BytesPerWord.
	csp := debugStackPointers at: bcpc.
	"Compensate lazily for absent receiver sends."
	(NewspeakVM
	 and: [asp - delta = csp
	 and: [cogit isAbsentReceiverSendAt: mcpc in: cogHomeMethod]]) ifTrue:
		[csp := debugStackPointers at: bcpc put: csp + 1].
	self assert: asp - delta + 1 = csp