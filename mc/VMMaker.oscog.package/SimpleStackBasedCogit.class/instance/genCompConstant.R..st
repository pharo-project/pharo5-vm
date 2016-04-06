bytecode generator support
genCompConstant: constant R: register
	<inline: true>
	^ (objectRepresentation shouldAnnotateObjectReference: constant)
		ifTrue: [ self annotate: (self CmpCw: constant R: register) objRef: constant ]
		ifFalse: [ self CmpCq: constant R: register ]
	