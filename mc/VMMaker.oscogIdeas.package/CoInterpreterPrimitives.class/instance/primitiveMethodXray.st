indexing primitives
primitiveMethodXray
	"Lift the veil from a method and answer an integer describing the interior state
	 of its machine code.
	 Used for e.g. VM tests so they can verify they're testing what they think they're testing.
	 0 implies a vanilla method.
	 Bit 0 = method might be compiled to machine code
	 Bit 1 = method is currently compiled to machine code
	 Bit 2 = is compiled frameless.
	 Bit 3 = method refers to young object.
	 Bit 4 = method too big to be jitted (more than 64k of code, or needs more than 1.5Mb of stack space to compile)
	 Bit 5 = method contains unknown/unjittable bytecode
	 Bit 6 = method should not be jitted because it contains a primitive not to be called from machine code (unused)"
	| alreadyCogged flags cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	(self methodWithHeaderShouldBeCogged: (objectMemory methodHeaderOf: self stackTop))
		ifTrue:
			[alreadyCogged := self maybeMethodHasCogMethod: self stackTop.
			 flags := 1.
			 alreadyCogged ifFalse:
				[cogMethod := cogit cog: self stackTop selector: objectMemory nilObject.
				 (cogMethod = nil
				  and: [cogCompiledCodeCompactionCalledFor]) ifTrue:
					[self commenceCogCompiledCodeCompaction.
					 cogMethod := cogit cog: self stackTop selector: objectMemory nilObject].
			 cogMethod asInteger
				caseOf: {
					[MethodTooBig] -> [flags := 1 + 16].
					[EncounteredUnknownBytecode] -> [flags := 1 + 32].
					[ShouldNotJIT] -> [flags := 1 + 64] }
				otherwise: [self deny: (cogMethod asInteger between: MaxNegativeErrorCode and: NotFullyInitialized)]].
			 (flags = 1
			  and: [self maybeMethodHasCogMethod: self stackTop]) ifTrue:
				[cogMethod := self cogMethodOf: self stackTop.
				 flags := cogMethod stackCheckOffset = 0 ifTrue: [7] ifFalse: [3].
				 cogMethod cmRefersToYoung ifTrue:
					[flags := flags + 8].
				 alreadyCogged ifFalse:
					[cogit freeMethod: cogMethod]]]
		ifFalse: [flags := 0].
	self pop: 1 thenPush: (objectMemory integerObjectOf: flags)