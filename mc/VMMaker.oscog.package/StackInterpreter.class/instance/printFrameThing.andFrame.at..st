debug printing
printFrameThing: name andFrame: theFP at: address
	<var: #theFP type: #'char *'>
	| it len |
	<inline: false>
	<var: #name type: #'char *'>
	<var: #address type: #'char *'>
	it := stackPages longAt: address.
	self printHexPtr: address;
		printChar: $:.
	len := self strlen: name.
	1 to: 12 - len do: [:i| self space].
	self print: name;
		print: ': ';
		printHex: it.
	it ~= 0 ifTrue:
		[self printChar: $=.
		 it = objectMemory nilObject
			ifTrue: [self print: 'nil']
			ifFalse:
				[self printNum: it]].
	self print: ' frame: '; printHexPtr: theFP; cr