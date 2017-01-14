method introspection
picDataFor: cogMethod into: arrayObj
	"Collect the branch and send data for cogMethod, storing it into arrayObj."
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	| errCode |
	cogMethod stackCheckOffset = 0 ifTrue:
		[^0].
	introspectionDataIndex := counterIndex := 0.
	introspectionData := arrayObj.
	errCode := self
					mapFor: (self cCoerceSimple: cogMethod to: #'CogBlockMethod *')
					bcpc: (coInterpreter startPCOfMethod: cogMethod methodObject)
					performUntil: #picDataFor:Annotation:Mcpc:Bcpc:Method:
					arg: cogMethod asVoidPointer.
	errCode ~= 0 ifTrue:
		[self assert: errCode = PrimErrNoMemory.
		 ^-1].
	cogMethod blockEntryOffset ~= 0 ifTrue:
		[errCode := self blockDispatchTargetsFor: cogMethod
						perform: #picDataForBlockEntry:Method:
						arg: cogMethod asInteger.
		 errCode ~= 0 ifTrue:
			[self assert: errCode = PrimErrNoMemory.
			 ^-1]].
	^introspectionDataIndex