simulation
ccgLoad: forProlog expr: failBlock asKindOfIntegerFrom: argIndexOrNil 
	^[:oop|
	   interpreterProxy success: (interpreterProxy isKindOfInteger: oop).
	   oop]