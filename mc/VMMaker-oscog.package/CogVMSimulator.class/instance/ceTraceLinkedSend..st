debug support
ceTraceLinkedSend: theReceiver
	| cogMethod delta |
	(sendCount := sendCount + 1) \\ 500 = 0 ifTrue:
		[self changed: #byteCountText].
	cogit printOnTrace ifTrue:
		[transcript print: byteCount; nextPut: $/; print: sendCount; space].
	cogit assertCStackWellAligned.
	super ceTraceLinkedSend: theReceiver.
	cogMethod := cogit cogBlockMethodSurrogateAt: (self stackTop - cogit traceLinkedSendOffset).
	cogMethod stackCheckOffset > 0 ifTrue:
		[delta := (cogMethod cmType = CMMethod
				   and: [cogMethod cmNumArgs > cogit numRegArgs])
					ifTrue: [cogMethod cmNumArgs + 1]
					ifFalse: [0].
		 self maybeCheckStackDepth: delta sp: stackPointer + BytesPerWord pc: (stackPages longAt: stackPointer)]. "skip return address for ceTraceLinkedSend call."
	^#continue