constant support
genPushConstant: constant
	"If the objectMemory allows it, generates a quick constant push, else generates a word constant push"
	<inline: true>
	^ (objectRepresentation shouldAnnotateObjectReference: constant)
		ifTrue: [ self annotate: (self PushCw: constant) objRef: constant ]
		ifFalse: [ self PushCq: constant ]
	