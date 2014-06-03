primitive support
checkForAndFollowForwardedPrimitiveState
	"In Spur a primitive may fail due to encountering a forwarder.
	 On failure check the accessorDepth for the primitive and
	 if non-negative scan the args to the depth, following any
	 forwarders.  Answer if any are found so the prim can be retried."
	<option: #SpurObjectMemory>
	| primIndex accessorDepth found |
	self assert: self successful not.
	found := false.
	primIndex := self primitiveIndexOf: newMethod.
	accessorDepth := primitiveAccessorDepthTable at: primIndex.
	"For the method-executing primitives, failure could have been in those primitives or the
	 primitives of the methods they execute.  find out which failed by seeing what is in effect."
	primIndex caseOf: {
		[117] -> 
			[primitiveFunctionPointer ~~ #primitiveExternalCall ifTrue:
				[accessorDepth := self primitiveAccessorDepthForExternalPrimitiveMethod: newMethod].
			 self assert: argumentCount = (self argumentCountOf: newMethod)].
		[118] -> "with tryPrimitive:withArgs: the argument count has nothing to do with newMethod's, so no arg count assert."
			[self assert: primitiveFunctionPointer = (self functionPointerFor: primIndex inClass: objectMemory nilObject)].
		[218] ->
			[primitiveFunctionPointer ~~ #primitiveDoNamedPrimitiveWithArgs ifTrue:
				[accessorDepth := self primitiveAccessorDepthForExternalPrimitiveMethod: newMethod].
			 self assert: argumentCount = (self argumentCountOf: newMethod)]. }
		otherwise:
			[self assert: primitiveFunctionPointer = (self functionPointerFor: primIndex inClass: objectMemory nilObject).
			 self assert: argumentCount = (self argumentCountOf: newMethod)].
	accessorDepth >= 0 ifTrue:
		[0 to: argumentCount do:
			[:index| | oop |
			oop := self stackValue: index.
			(objectMemory isNonImmediate: oop) ifTrue:
				[(objectMemory isForwarded: oop) ifTrue:
					[self assert: index < argumentCount. "receiver should have been caught at send time."
					 found := true.
					 oop := objectMemory followForwarded: oop.
					 self stackValue: index put: oop].
				((objectMemory hasPointerFields: oop)
				 and: [objectMemory followForwardedObjectFields: oop toDepth: accessorDepth]) ifTrue:
					[found := true]]]].
	^found