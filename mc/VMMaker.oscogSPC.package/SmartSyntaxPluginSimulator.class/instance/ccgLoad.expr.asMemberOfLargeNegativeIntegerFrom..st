simulation
ccgLoad: forProlog expr: failBlock asMemberOfLargeNegativeIntegerFrom: argIndexOrNil 
	^[:oop|
	   interpreterProxy success: (interpreterProxy isLargeNegativeIntegerObject: oop).
	   oop]