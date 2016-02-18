method introspection
picDataFor: descriptor Annotation: annotation Mcpc: mcpc Bcpc: bcpc Method: cogMethodArg
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #cogMethodArg type: #'void *'>
	| entryPoint tuple counter |
	<var: #counter type: #'unsigned long'>

	descriptor ifNil:
		[^0].
	descriptor isBranch ifTrue:
		["it's a branch; conditional?"
		 (descriptor isBranchTrue or: [descriptor isBranchFalse]) ifTrue:
			[counter := (self
							cCoerce: ((self
											cCoerceSimple: cogMethodArg
											to: #'CogMethod *') counters)
							to: #'unsigned long *')
								at: counterIndex.
			 tuple := self picDataForCounter: counter at: bcpc + 1.
			 tuple = 0 ifTrue: [^PrimErrNoMemory].
			 objectMemory storePointer: picDataIndex ofObject: picData withValue: tuple.
			 picDataIndex := picDataIndex + 1.
			 counterIndex := counterIndex + 1].
		 ^0].
	((self isPureSendAnnotation: annotation)
	 and: [entryPoint := backEnd callTargetFromReturnAddress: mcpc asUnsignedInteger.
		 entryPoint > methodZoneBase]) ifFalse: "send is not linked, or is not a send"
		[^0].
	self targetMethodAndSendTableFor: entryPoint "It's a linked send; find which kind."
		annotation: annotation
		into: [:targetMethod :sendTable| | methodClassIfSuper association |
			methodClassIfSuper := nil.
			sendTable = superSendTrampolines ifTrue:
				[methodClassIfSuper := coInterpreter methodClassOf: (self cCoerceSimple: cogMethodArg to: #'CogMethod *') methodObject].
			sendTable = directedSuperSendTrampolines ifTrue:
				[association := backEnd literalBeforeInlineCacheTagAt: mcpc asUnsignedInteger.
				 methodClassIfSuper := objectRepresentation valueOfAssociation: association].
			tuple := self picDataForSendTo: targetMethod
						methodClassIfSuper: methodClassIfSuper
						at: mcpc
						bcpc: bcpc + 1].
	tuple = 0 ifTrue: [^PrimErrNoMemory].
	objectMemory storePointer: picDataIndex ofObject: picData withValue: tuple.
	picDataIndex := picDataIndex + 1.
	^0