bytecode generators
genSistaExtStoreAndPopReceiverVariableBytecodePopBoolean: popBoolean
	<inline: true>
	| index needsStoreCheck needsImmCheck maybeContext |
	needsStoreCheck := self sistaNeedsStoreCheck.
	needsImmCheck := self extBSpecifiesImmCheck.
	"Long form and short form exist for popInto. Only the long form exists for store.
	Store have an explicit flag to mark context accessing, while popInto context accessing are done through the long form,
	hence generate the context form if the flag is set or if this is a popInto."
	maybeContext := popBoolean or: [self extBSpecifiesMaybeContext].
	extB := 0.
	index := byte1 + (extA << 8).
	extA := 0.
	^((coInterpreter isWriteMediatedContextInstVarIndex: index) and: [maybeContext])
		ifTrue: [self 
				genStorePop: popBoolean 
				MaybeContextReceiverVariable: index 
				needsStoreCheck: needsStoreCheck 
				needsImmutabilityCheck: needsImmCheck]
		ifFalse: [self 
				 genStorePop: popBoolean 
				 ReceiverVariable: index 
				 needsStoreCheck: needsStoreCheck 
				 needsImmutabilityCheck: needsImmCheck]