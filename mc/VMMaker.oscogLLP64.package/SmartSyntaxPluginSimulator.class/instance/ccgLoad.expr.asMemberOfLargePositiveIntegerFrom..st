simulation
ccgLoad: forProlog expr: failBlock asMemberOfLargePositiveIntegerFrom: argIndexOrNil 
	^[:oop|
	   interpreterProxy success: (interpreterProxy isLargePositiveIntegerObject: oop).
	   oop]