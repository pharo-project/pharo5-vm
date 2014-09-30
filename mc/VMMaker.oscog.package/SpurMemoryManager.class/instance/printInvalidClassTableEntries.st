class table
printInvalidClassTableEntries
	"Print the objects in the classTable that have bad hashes."
	<api>
	self validClassTableRootPages ifFalse:
		[coInterpreter print: 'class table invalid; cannot print'; cr.
		 ^self].

	self classTableEntriesDo:
		[:classOrNil :index| | hash |
		 ((self isForwarded: classOrNil)
		  or: [(hash := self rawHashBitsOf: classOrNil) = 0
		  or: [(self noCheckClassAtIndex: hash) ~= classOrNil]]) ifTrue:
			[coInterpreter
				print: 'entry '; printHex: index;
				print: ' oop '; printHex: classOrNil;
				print: ' hash '; printHex: hash; print: ' => '; printHex: (self classAtIndex: hash);
				cr]]