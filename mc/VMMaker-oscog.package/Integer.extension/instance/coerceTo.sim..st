*VMMaker-interpreter simulator
coerceTo: cTypeString sim: interpreter

	| unitSize |

	cTypeString last = $* ifTrue: [  "C pointer"
		unitSize := cTypeString caseOf: {
		['char *'] -> [1].
		['short *'] -> [4].
		['int *'] -> [4].
		['float *'] -> [4].
		['double *'] -> [8].
		['unsigned *'] -> [4].
		['oop *'] -> [interpreter bytesPerOop].
		}
		otherwise: [ (cTypeString beginsWith: 'char') ifTrue: [1] ifFalse: [4] ].
		^(CArray basicNew)
			interpreter: interpreter address: self unitSize: unitSize;
			yourself.
	].
	^ self  "C number (int, char, float, etc)"