class table
printInvalidClassTableHashes
	"Print the entries in the classTable that have invalid hashes."

	self validClassTableRootPages ifFalse:
		[^false].

	self classTableEntriesDo:
		[:entry :index| | hash |
		 (self isForwarded: entry)
			ifTrue:
				[coInterpreter printHex: entry; print: ' @ '; printHex: index; print: ' forwarder']
			ifFalse:
				[hash := self rawHashBitsOf: entry.
				 hash = 0
					ifTrue:
						[coInterpreter printHex: entry; print: ' @ '; printHex: index; print: ' no hash']
					ifFalse:
						[(self noCheckClassAtIndex: hash) ~= entry ifTrue:
							[coInterpreter printHex: entry; print: ' @ '; printHex: index; print: ' bad hash: '; printHex: hash]]]]