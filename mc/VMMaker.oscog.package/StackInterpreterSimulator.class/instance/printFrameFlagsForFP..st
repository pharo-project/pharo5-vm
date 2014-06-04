debug printing
printFrameFlagsForFP: theFP
	| address it |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #address type: #'char *'>
	address := theFP + FoxFrameFlags.
	it := stackPages longAt: address.
	self printHex: address;
		printChar: $/;
		printNum: (stackPages memIndexFor: address);
		print: ':       flags: ';
		printHex: it.
	it ~= 0 ifTrue:
		[self printChar: $=; printNum: it].
	self print: '  numArgs: '; printNum: (self frameNumArgs: theFP);
		print: '  hasContext: '; printNum: (self frameHasContext: theFP);
		print: '  isBlock: '; printNum: (self frameIsBlockActivation: theFP);
		cr