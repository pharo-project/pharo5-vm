debug printing
printCogMethod: cogMethod
	<api>
	<var: #cogMethod type: #'CogMethod *'>
	| address primitive |
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
			printHex: cogMethod methodObject.
		 primitive := self primitiveIndexOfMethod: cogMethod methodObject
							header: cogMethod methodHeader.
		 primitive ~= 0 ifTrue:
			[self print: ' prim '; printNum: primitive]].
	cogMethod cmType = CMBlock ifTrue:
		[self print: ': block home: ';
			printHex: (self cCoerceSimple: cogMethod to: #'CogBlockMethod *') cmHomeMethod asUnsignedInteger].
	cogMethod cmType = CMClosedPIC ifTrue:
		[self print: ': Closed PIC N: ';
			printHex: cogMethod cPICNumCases].
	cogMethod cmType = CMOpenPIC ifTrue:
		[self print: ': Open PIC '].
	self print: ' selector: '; printHex: cogMethod selector.
	cogMethod selector = objectMemory nilObject
		ifTrue: [self print: ' (nil)']
		ifFalse: [self space; printStringOf: cogMethod selector].
	self cr