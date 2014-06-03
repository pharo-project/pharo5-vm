method map
annotate: abstractInstruction objRef: anOop
	<var: #abstractInstruction type: #'AbstractInstruction *'>
	<returnTypeC: #'AbstractInstruction *'>
	(objectRepresentation shouldAnnotateObjectReference: anOop) ifTrue:
		[(objectMemory isYoungObject: anOop) ifTrue:
			[hasYoungReferent := true].
		^self annotate: abstractInstruction with: IsObjectReference].
	^abstractInstruction