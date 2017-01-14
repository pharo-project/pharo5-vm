debug printing
printFrameThing: name at: address
	| it |
	<inline: false>
	<var: #name type: #'char *'>
	<var: #address type: #'char *'>
	it := stackPages longAt: address.
	self printHex: address;
		printChar: $/;
		printNum: (stackPages memIndexFor: address);
		printChar: $:.
	1 to: 12 - (self strlen: name) do: [:i| self printChar: $ ].
	self print: name;
		print: ': ';
		printHex: it.
	it ~= 0 ifTrue:
		[self printChar: $=; printNum: it].
	self cr