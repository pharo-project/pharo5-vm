debug printing
printFrameOop: name obj: obj at: address
	| it len |
	<inline: false>
	<var: #name type: #'char *'>
	<var: #address type: #'char *'>
	it := stackPages longAt: address.
	self printHex: address;
		printChar: $:.
	len := self strlen: name.
	1 to: 12 - len do: [:i| self printChar: $ ].
	self print: name;
		print: ': ';
		printHex: it.
	self tab.
	it = obj
		ifTrue: [self tab]
		ifFalse: [self printHex: obj; space].
	self
		print: (self shortPrint: obj);
		cr