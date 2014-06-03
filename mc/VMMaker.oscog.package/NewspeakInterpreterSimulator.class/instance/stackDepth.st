testing
stackDepth
	| ctxt n |
	ctxt := activeContext.
	n := 0.
	[(ctxt := (self fetchPointer: SenderIndex ofObject: ctxt)) = nilObj]
		whileFalse: [n := n+1].
	^ n