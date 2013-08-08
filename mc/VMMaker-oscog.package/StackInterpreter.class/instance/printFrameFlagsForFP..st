debug printing
printFrameFlagsForFP: theFP
	| address it |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #address type: #'char *'>
	address := theFP + FoxFrameFlags.
	it := stackPages longAt: address.
	self printHexPtr: address;
		print: ':       flags: ';
		printHex: it.
	it ~= 0 ifTrue:
		[self printChar: $=; printNum: it].
	self print: '  numArgs: '; printNum: (self frameNumArgs: theFP);
		print: ((self frameHasContext: theFP) ifTrue: [' hasContext'] ifFalse: [' noContext']);
		print: ((self frameIsBlockActivation: theFP) ifTrue: [' isBlock'] ifFalse: [' notBlock']);
		cr