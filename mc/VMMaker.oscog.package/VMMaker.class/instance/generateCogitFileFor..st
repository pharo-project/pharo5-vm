generate sources
generateCogitFileFor: cogitClass
	"Translate the Smalltalk description of the virtual machine into C.  If 'self doInlining' is true, small method bodies are inlined to reduce procedure call overhead.  On the PPC, this results in a factor of three speedup with only 30% increase in code size.  Subclasses can use specialised versions of CCodeGenerator and interpreterClass."

	| cg |
	cg := [self buildCodeGeneratorForCogit]
			on: Notification
			do: [:ex|
				ex tag == #getVMMaker
					ifTrue: [ex resume: self]
					ifFalse: [(ex respondsTo: #rearmHandlerDuring:)
								ifTrue: [ex rearmHandlerDuring: [ex pass]]
								ifFalse: [ex pass]]].
	self needsToRegenerateCogitFile ifFalse: [^cg].

	cg inferTypesForImplicitlyTypedVariablesAndMethods.

	cg vmClass preGenerationHook: cg.
	cg storeCodeOnFile: (self sourceFilePathFor: cogitClass processorSpecificSourceFileName) doInlining: cogitClass doInlining.
	^cg