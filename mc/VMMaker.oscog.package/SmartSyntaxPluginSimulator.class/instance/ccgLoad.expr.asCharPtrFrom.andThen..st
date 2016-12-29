simulation
ccgLoad: codeGen expr: exprBlock asCharPtrFrom: stackIndex andThen: validateBlock
	^[:oop|
	   validateBlock value: oop.
	   interpreterProxy cCoerce: (interpreterProxy firstIndexableField: oop) asInteger to: #'char *']