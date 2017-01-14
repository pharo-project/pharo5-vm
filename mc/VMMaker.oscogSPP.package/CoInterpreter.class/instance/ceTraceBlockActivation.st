debug support
ceTraceBlockActivation
	<api>
	cogit recordBlockTrace ifTrue:
		[self recordTrace: TraceBlockActivation
			thing: (self mframeHomeMethod: framePointer) methodObject
			source: TraceIsFromMachineCode.
		 cogit printOnTrace ifTrue:
			[self printActivationNameFor: (self mframeHomeMethod: framePointer) methodObject
				receiver: (self frameReceiver: framePointer)
				isBlock: true
				firstTemporary: nil.
			 self cr]]