accessing
ultimateLiteralOf: methodObj
	| meth |
	meth := (objectMap keyAtValue: methodObj).
	^self oopForObject: (meth literalAt: meth numLiterals)