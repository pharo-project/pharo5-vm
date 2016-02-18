bytecode generator support
genMoveConstant: constant R: reg
	<inline: true>
	^ (objectRepresentation shouldAnnotateObjectReference: constant)
		ifTrue: [ (self annotate: (self MoveCw: constant R: reg) objRef: constant) ]
		ifFalse: [ self MoveCq: constant R: reg ]
	
	