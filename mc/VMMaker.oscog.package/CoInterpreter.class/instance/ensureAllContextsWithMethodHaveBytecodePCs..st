frame access
ensureAllContextsWithMethodHaveBytecodePCs: methodObj
	"Map all native pcs to bytecoded pcs in all contexts on methodObj.
	 Used to implement primitiveVoidVMStateForMethod."
	objectMemory allObjectsDo:
		[:oop|
		 ((objectMemory isContextNonImm: oop)
		  and: [(objectMemory fetchPointer: MethodIndex ofObject: oop) = methodObj]) ifTrue:
			[self widowOrForceToBytecodePC: oop]]