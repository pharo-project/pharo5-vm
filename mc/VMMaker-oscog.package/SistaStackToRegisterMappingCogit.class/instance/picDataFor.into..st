method introspection
picDataFor: cogMethod into: arrayObj
	"Answer the zero-relative bytecode pc matching the machine code pc argument in
	 cogMethod, given the start of the bytecodes for cogMethod's block or method object."
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	| errCode |
	cogMethod stackCheckOffset = 0 ifTrue:
		[^0].
	picDataIndex := 0.
	picData := arrayObj.
	errCode := self
					mapFor: (self cCoerceSimple: cogMethod to: #'CogBlockMethod *')
					bcpc: (coInterpreter startPCOfMethod: cogMethod methodObject)
					performUntil: #picDataFor:Mcpc:Bcpc:Method:
					arg: (self cCoerceSimple: cogMethod to: #'void *').
	errCode ~= 0 ifTrue:
		[self assert: errCode = PrimErrNoMemory.
		 ^-1].
	^picDataIndex