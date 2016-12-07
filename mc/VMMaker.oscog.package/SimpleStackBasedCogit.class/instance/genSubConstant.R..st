constant support
genSubConstant: constant R: reg
	"If the objectMemory allows it, generates a quick constant sub, else generates a word constant sub"
	<inline: true>
	^ (objectRepresentation shouldAnnotateObjectReference: constant)
		ifTrue: [ self annotate: (self SubCw: constant R: reg) objRef: reg. ]
		ifFalse: [ self SubCq: constant R: reg ]