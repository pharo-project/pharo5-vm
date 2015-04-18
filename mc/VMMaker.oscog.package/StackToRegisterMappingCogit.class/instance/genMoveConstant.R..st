bytecode generator support
genMoveConstant: constant R: register
	<inline: true>
	^ (objectRepresentation shouldAnnotateObjectReference: constant)
		ifTrue: [ (self annotate: (self MoveCw: constant R: register) objRef: constant) ]
		ifFalse: [ self MoveCq: constant R: register ]
	
	