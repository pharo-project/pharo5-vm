*VMMaker-interpreter simulator
coerceTo: cTypeString sim: interpreter

	| unitSize |
	cTypeString last = $* ifTrue:  "C pointer"
		[unitSize := cTypeString caseOf: {
		['char *'] -> [1].
		['short *'] -> [2].
		['int *'] -> [4].
		['float *'] -> [^CFloatArray basicNew interpreter: interpreter address: self unitSize: 4; yourself].
		['double *'] -> [^CFloatArray basicNew interpreter: interpreter address: self unitSize: 8; yourself].
		['unsigned *'] -> [4].
		['unsigned int *'] -> [4].
		['unsigned char *'] -> [1].
		['signed char *'] -> [1].
		['unsigned short *'] -> [2].
		['oop *'] -> [interpreter bytesPerOop].
		}
		otherwise: [interpreter wordSize].
		^CArray basicNew
			interpreter: interpreter address: self unitSize: unitSize;
			yourself].
	^self  "C number (int, char, float, etc)"