class table
printInvalidClassTableEntries
	"Print the objects in the classTable that have bad hashes."
	<api>
	self validClassTableRootPages ifFalse:
		[coInterpreter print: 'class table invalid; cannot print'; cr.
		 ^self].

	0 to: numClassTablePages - 1 do:
		[:i| | page |
		 page := self fetchPointer: i ofObject: hiddenRootsObj.
		 0 to: self classTablePageSize - 1 do:
			[:j| | classOrNil hash |
			classOrNil := self fetchPointer: j ofObject: page.
			classOrNil ~= nilObj ifTrue:
				[((self isForwarded: classOrNil)
				  or: [(hash := self rawHashBitsOf: classOrNil) = 0
				  or: [(self noCheckClassAtIndex: hash) ~= classOrNil]]) ifTrue:
					[coInterpreter
						print: 'entry '; printHex: i * self classTablePageSize + j;
						print: ' oop '; printHex: classOrNil;
						print: ' hash '; printHex: hash; print: ' => '; printHex: (self classAtIndex: hash);
						cr]]]]