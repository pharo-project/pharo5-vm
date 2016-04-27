frame access
ensureAllContextsWithMethodHaveBytecodePCs: methodObj
	"Map all native pcs to bytecoded pcs in all contexts on methodObj.
	 Used to implement primitiveVoidVMStateForMethod."
	objectMemory allObjectsDo:
		[:oop|
		 ((objectMemory isContextNonImm: oop)
		  and: [(objectMemory fetchPointer: MethodIndex ofObject: oop) = methodObj]) ifTrue:
			[(self isMarriedOrWidowedContext: oop)
				ifTrue:
					"Since any machine-code frame activations of the method have been divorced
					 there should only be interpreted activations of marriecd contexts."
					[(self isWidowedContext: oop) ifFalse:
						[self deny: (self isMachineCodeFrame: (self frameOfMarriedContext: oop))]]
				ifFalse:
					[self ensureContextHasBytecodePC: oop]]]