simulation
ccgLoad: codeGen expr: exprBlock asOopPtrFrom: stackIndex andThen: validateBlock
	^[:oop|
	   validateBlock value: oop.
	   interpreterProxy cCoerce: (interpreterProxy firstIndexableField: oop) asInteger to: #'sqInt *']