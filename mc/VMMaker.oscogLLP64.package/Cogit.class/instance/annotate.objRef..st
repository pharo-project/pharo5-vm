method map
annotate: abstractInstruction objRef: anOop
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	(objectRepresentation shouldAnnotateObjectReference: anOop) ifTrue:
		[(objectMemory isYoungObject: anOop) ifTrue:
			[hasYoungReferent := true].
		 abstractInstruction annotation: IsObjectReference].
	^abstractInstruction