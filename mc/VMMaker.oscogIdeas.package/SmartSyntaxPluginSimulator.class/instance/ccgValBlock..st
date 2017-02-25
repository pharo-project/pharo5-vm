simulation
ccgValBlock: aString 
	^aString caseOf: {
		['isBytes']			-> [	[:oop|
								 interpreterProxy success: (interpreterProxy isBytes: oop).
								 oop]].
		['isWordsOrBytes']	-> [	[:oop|
								 interpreterProxy success: (interpreterProxy isWordsOrBytes: oop).
								 oop]] }