debug support
ceTraceLinkedSend: theReceiver
	| cogMethod |
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := self cCoerceSimple: (self stackTop - cogit traceLinkedSendOffset)
						to: #'CogMethod *'.
	self cCode: [] inSmalltalk:
		[cogit checkStackDepthOnSend ifTrue:
			[self maybeCheckStackDepth: (cogMethod cmNumArgs > cogit numRegArgs
											ifTrue: [cogMethod cmNumArgs + 1]
											ifFalse: [0])
				sp: stackPointer + objectMemory wordSize
				pc: (self stackValue: 1)]].
	"cogit recordSendTrace ifTrue: is implicit; wouldn't compile the call otherwise."
	self recordTrace: (objectMemory fetchClassOf: theReceiver)
		thing: cogMethod selector
		source: TraceIsFromMachineCode.
	cogit printOnTrace ifTrue:
		[self printActivationNameFor: cogMethod methodObject
			receiver: theReceiver
			isBlock: false
			firstTemporary: (self cCode: [nil] inSmalltalk: [0]);
			cr].
	self sendBreakpoint: cogMethod selector receiver: theReceiver