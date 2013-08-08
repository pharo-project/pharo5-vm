accessing
cmHomeMethod
	<returnTypeC: #'CogMethod *'>
	^self cCoerceSimple: self asUnsignedInteger - self homeOffset to: #'CogMethod *'