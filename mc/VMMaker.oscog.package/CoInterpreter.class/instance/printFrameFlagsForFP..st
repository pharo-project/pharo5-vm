debug printing
printFrameFlagsForFP: theFP
	| address it |
	<inline: false>
	<var: #theFP type: #'char *'>
	<var: #address type: #'char *'>
	(self isMachineCodeFrame: theFP)
		ifTrue:
			[address := theFP + FoxMethod.
			it := (stackPages longAt: address) bitAnd: 16r7]
		ifFalse:
			[address := theFP + FoxIFrameFlags.
			 it := stackPages longAt: address].
	self printHexPtr: address;
		print: ((self isMachineCodeFrame: theFP)
				ifTrue: [': mcfrm flags: ']
				ifFalse: [':intfrm flags: ']);
		printHex: it.
	it ~= 0 ifTrue:
		[self printChar: $=; printNum: it].
	self print: '  numArgs: '; printNum: (self frameNumArgs: theFP);
		print: ((self frameHasContext: theFP) ifTrue: [' hasContext'] ifFalse: [' noContext']);
		print: ((self frameIsBlockActivation: theFP) ifTrue: [' isBlock'] ifFalse: [' notBlock']);
		cr