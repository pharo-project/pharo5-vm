debug support
printStack: includeTemps
	| ctxt |
	ctxt := activeContext.
	^ String streamContents:
		[:strm |
		[self printStackFrame: ctxt onStream: strm.
		includeTemps ifTrue: [self printStackTemps: ctxt onStream: strm].
		(ctxt := (self fetchPointer: SenderIndex ofObject: ctxt)) = nilObj]
				whileFalse: [].
		]