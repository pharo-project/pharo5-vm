frame access
widowOrForceToBytecodePC: ctxt
	"Either widow the context or map its pc to a bytecode one.
	 Used to implement primitiveVoidVMStateForMethod."
	<inline: #never> "for debugging & saving space"
	(self isMarriedOrWidowedContext: ctxt)
		ifTrue:
			"Since any machine-code frame activations of the method have been divorced
			 there should only be interpreted activations of marriecd contexts."
			[(self isWidowedContext: ctxt) ifFalse:
				[self deny: (self isMachineCodeFrame: (self frameOfMarriedContext: ctxt))]]
		ifFalse:
			[self ensureContextHasBytecodePC: ctxt]