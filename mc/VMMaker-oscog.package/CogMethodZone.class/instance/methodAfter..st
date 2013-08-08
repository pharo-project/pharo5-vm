accessing
methodAfter: cogMethod
	<returnTypeC: #'CogMethod *'>
	<var: #cogMethod type: #'CogMethod *'>
	^coInterpreter
		cCoerceSimple: (self roundUpLength: cogMethod asInteger + cogMethod blockSize)
		to: #'CogMethod *'