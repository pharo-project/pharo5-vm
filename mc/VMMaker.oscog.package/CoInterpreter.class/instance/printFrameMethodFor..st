debug printing
printFrameMethodFor: theFP
	<inline: false>
	| address it homeMethod obj |
	<var: #theFP type: #'char *'>
	<var: #address type: #'char *'>
	<var: #homeMethod type: #'CogMethod *'>

	address := theFP + FoxMethod.
	it := stackPages longAt: address.
	self printHex: address asInteger;
		printChar: $:.
	self print: '      method: ';
		printHex: it.
	self tab.
	((self isMachineCodeFrame: theFP)
	 and: [self mframeIsBlockActivation: theFP]) ifTrue:
		[homeMethod := self mframeHomeMethod: theFP.
		 self print: 'hm: '; printHex: homeMethod asInteger; tab].
	obj := self frameMethodObject: theFP.
	self printHex: obj; space; shortPrintOop: obj