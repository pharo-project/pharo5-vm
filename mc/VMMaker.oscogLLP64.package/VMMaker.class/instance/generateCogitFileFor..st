generate sources
generateCogitFileFor: cogitClass
	"Translate the Smalltalk description of the Cogit into C, if required.  Ensure that
	 inferTypesForImplicitlyTypedVariablesAndMethods was done, and answer the code generator."

	| cg |
	cg := [self buildCodeGeneratorForCogit]
			on: Notification
			do: [:ex|
				ex tag == #getVMMaker
					ifTrue: [ex resume: self]
					ifFalse: [(ex respondsTo: #rearmHandlerDuring:)
								ifTrue: [ex rearmHandlerDuring: [ex pass]]
								ifFalse: [ex pass]]].

	cg inferTypesForImplicitlyTypedVariablesAndMethods.
	self needsToRegenerateCogitFile ifFalse: [^cg].

	cg vmClass preGenerationHook: cg.
	cg storeCodeOnFile: (self sourceFilePathFor: cogitClass processorSpecificSourceFileName) doInlining: cogitClass doInlining.
	^cg