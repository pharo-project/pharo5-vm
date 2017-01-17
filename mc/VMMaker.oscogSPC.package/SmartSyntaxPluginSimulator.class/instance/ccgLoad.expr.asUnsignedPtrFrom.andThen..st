simulation
ccgLoad: codeGen expr: exprBlock asUnsignedPtrFrom: stackIndex andThen: validateBlock
	^[:oop|
	   validateBlock value: oop.
	   interpreterProxy cCoerce: (interpreterProxy firstIndexableField: oop) asInteger to: #'unsigned *']