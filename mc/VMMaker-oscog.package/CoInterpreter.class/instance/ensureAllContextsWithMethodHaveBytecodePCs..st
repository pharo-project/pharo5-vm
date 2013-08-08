frame access
ensureAllContextsWithMethodHaveBytecodePCs: methodObj
	"Map all native pcs to bytecoded pcs in all contexts on methodObj.
	 Used to implement primitiveVoidVMStateForMethod."
	| oop |
	oop := objectMemory firstObject.
	[oop < objectMemory freeStart] whileTrue:
		[((objectMemory isFreeObject: oop) not
		  and: [(objectMemory isContextNonInt: oop)
		  and: [(objectMemory fetchPointer: MethodIndex ofObject: oop) = methodObj]]) ifTrue:
			[(self isMarriedOrWidowedContext: oop)
				ifTrue:
					[(self checkIsStillMarriedContext: oop currentFP: stackPage headFP) ifTrue:
						[self assert: (self isMachineCodeFrame: (self frameOfMarriedContext: oop)) not]]
				ifFalse:
					[self ensureContextHasBytecodePC: oop]].
		 oop := objectMemory objectAfter: oop]