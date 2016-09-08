constant support
genCmpConstant: constant R: register
	"If the objectMemory allows it, generates a quick constant cmp, else generates a word constant cmp"
	<inline: true>
	^ (objectRepresentation shouldAnnotateObjectReference: constant)
		ifTrue: [ self annotate: (self CmpCw: constant R: register) objRef: constant ]
		ifFalse: [ self CmpCq: constant R: register ]
	