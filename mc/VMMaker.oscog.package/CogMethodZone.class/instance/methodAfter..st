accessing
methodAfter: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	<inline: true>
	^coInterpreter
		cCoerceSimple: (self roundUpLength: cogMethod asInteger + cogMethod blockSize)
		to: #'CogMethod *'