primitive support
checkForAndFollowForwardedPrimitiveState
	"In Spur a primitive may fail due to encountering a forwarder. On failure,
	 check the accessorDepth for the primitive and if non-negative scan the
	 args to the depth, following any forwarders.  Answer if any are found so
	 the prim can be retried.  The primitive index is derived from newMethod.
	 If the primitive is 118, then primitiveDoPrimitiveWithArgs sets newMethod
	 to a SmallInteger whose value is the primitive it is evaluating."
	<option: #SpurObjectMemory>
	| primIndex accessorDepth found scannedStackFrame |
	self assert: self failed.
	found := scannedStackFrame := false.
	primIndex := (objectMemory isIntegerObject: newMethod)
					ifTrue: [objectMemory integerValueOf: newMethod]
					ifFalse:
						[self assert: argumentCount = (self argumentCountOf: newMethod).
						 self primitiveIndexOf: newMethod].
	accessorDepth := primitiveAccessorDepthTable at: primIndex.
	"For the method-executing primitives, failure could have been in those primitives or the
	 primitives of the methods they execute.  Find out which failed by seeing what is in effect."
	((primIndex = PrimNumberExternalCall and: [primitiveFunctionPointer ~~ #primitiveExternalCall])
	 or: [primIndex = PrimNumberDoExternalCall and: [primitiveFunctionPointer ~~ #primitiveDoNamedPrimitiveWithArgs]])
		ifTrue:
			[accessorDepth := self primitiveAccessorDepthForExternalPrimitiveMethod: newMethod]
		ifFalse:
			[self assert: (self saneFunctionPointerForFailureOfPrimIndex: primIndex)].
	self assert: (accessorDepth between: -1 and: 4).
	accessorDepth >= 0 ifTrue:
		[0 to: argumentCount do:
			[:index| | oop |
			oop := self stackValue: index.
			(objectMemory isNonImmediate: oop) ifTrue:
				[(objectMemory isForwarded: oop) ifTrue:
					[self assert: index < argumentCount. "receiver should have been caught at send time."
					 found := true.
					 oop := objectMemory followForwarded: oop.
					 self stackValue: index put: oop.
					 scannedStackFrame ifFalse:
						[scannedStackFrame := true.
						 self
							followForwardedFrameContents: framePointer
							stackPointer: stackPointer + (argumentCount + 1 * objectMemory wordSize) "don't repeat effort"]].
				(accessorDepth > 0
			 	 and: [(objectMemory hasPointerFields: oop)
				 and: [objectMemory followForwardedObjectFields: oop toDepth: accessorDepth]]) ifTrue:
					[found := true]]]].
	^found