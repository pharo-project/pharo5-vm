debug printing
printCogMethod: cogMethod
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	| address |
	self cCode: ''
		inSmalltalk:
			[self transcript ensureCr.
			 cogMethod isInteger ifTrue:
				[^self printCogMethod: (self cCoerceSimple: cogMethod to: #'CogMethod *')]].
	address := cogMethod asInteger.
	self printHex: address;
		print: ' <-> ';
		printHex: address + cogMethod blockSize.
	cogMethod cmType = CMMethod ifTrue:
		[self print: ': method: ';
			printHex: cogMethod methodObject].
	cogMethod cmType = CMBlock ifTrue:
		[self print: ': block home: ';
			printHex: (self cCoerceSimple: cogMethod to: #'CogBlockMethod *') cmHomeMethod asUnsignedInteger].
	cogMethod cmType = CMClosedPIC ifTrue:
		[self print: ': Closed PIC N: ';
			printHex: cogMethod cPICNumCases].
	cogMethod cmType = CMOpenPIC ifTrue:
		[self print: ': Open PIC '].
	self print: ' selector: ';
		printHex: cogMethod selector;
		print: ' ';
		printStringOf: cogMethod selector;
		cr