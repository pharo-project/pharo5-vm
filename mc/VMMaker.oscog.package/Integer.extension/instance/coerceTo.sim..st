*VMMaker-interpreter simulator
coerceTo: cTypeString sim: interpreter

	| unitSize |
	cTypeString last = $* ifTrue:  "C pointer"
		[unitSize := cTypeString caseOf: {
		['char *'] -> [1].
		['short *'] -> [2].
		['int *'] -> [4].
		['long *'] -> [interpreter wordSize].
		['float *'] -> [4].
		['double *'] -> [8].
		['unsigned *'] -> [4].
		['unsigned int *'] -> [4].
		['unsigned char *'] -> [4].
		['unsigned short *'] -> [4].
		['oop *'] -> [interpreter bytesPerOop].
		}
		otherwise: [ (cTypeString beginsWith: 'char') ifTrue: [1] ifFalse: [interpreter wordSize] ].
		^CArray basicNew
			interpreter: interpreter address: self unitSize: unitSize;
			yourself].
	^ self  "C number (int, char, float, etc)"