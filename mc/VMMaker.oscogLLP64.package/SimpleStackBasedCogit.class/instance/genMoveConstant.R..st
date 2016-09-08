constant support
genMoveConstant: constant R: reg
	"If the objectMemory allows it, generates a quick constant move, else generates a word constant move"
	<inline: true>
	^ (objectRepresentation shouldAnnotateObjectReference: constant)
		ifTrue: [ self annotate: (self MoveCw: constant R: reg) objRef: constant ]
		ifFalse: [ self MoveCq: constant R: reg ]
	
	