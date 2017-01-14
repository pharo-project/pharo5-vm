simulation
ccgLoad: codeGen expr: exprBlock asIntPtrFrom: stackIndex andThen: validateBlock
	^[:oop|
	   validateBlock value: oop.
	   interpreterProxy cCoerce: (interpreterProxy firstIndexableField: oop) asInteger to: #'int *']