debug printing
printFrameThing: name andFrame: theFP at: address
	<var: #theFP type: #'char *'>
	| it |
	<inline: false>
	<var: #name type: #'char *'>
	<var: #address type: #'char *'>
	it := stackPages longAt: address.
	self printHex: address;
		printChar: $:.
	1 to: 12 - (self strlen: name) do: [:i| self printChar: $ ].
	self print: name;
		print: ': ';
		printHex: it.
	it ~= 0 ifTrue:
		[self printChar: $=; printNum: it.
		 (objectMemory isInMemory: it) ifFalse:
			[(cogit lookupAddress: it) ifNotNil:
				[:label| self space; printChar: $(; print: label; printChar: $)]]].
	self print: ' frame: '; printHex: theFP; cr