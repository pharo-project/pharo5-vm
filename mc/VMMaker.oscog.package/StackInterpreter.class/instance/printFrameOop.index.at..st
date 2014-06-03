debug printing
printFrameOop: name index: idx at: address
	| it |
	<inline: false>
	<var: #name type: #'char *'>
	<var: #address type: #'char *'>
	it := stackPages longAt: address.
	self printHexPtr: address;
		printChar: $:.
	1	to: 11 - (self strlen: name) - (self log10: (idx max: 1)) floor
		do: [:i| self printChar: $ ].
	self print: name;
		printNum: idx;
		print: ': ';
		printHex: it;
		tab;
		printChar: $=;
		printOopShort: it;
		cr