type inference
typeFor: aNode in: aTMethod
	"Override to provide the type for InterpreterProxy's implicit stack variable."
	aNode isVariable ifTrue:
		[^(aTMethod typeFor: aNode in: self) ifNil:
			[aNode name = 'stack'
				ifTrue: [#'sqInt *']
				ifFalse: [#sqInt]]].
	^super typeFor: aNode in: aTMethod