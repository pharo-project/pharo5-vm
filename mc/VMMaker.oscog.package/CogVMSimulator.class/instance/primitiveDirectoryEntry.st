file primitives
primitiveDirectoryEntry
	| name pathName arrayNilOrSymbol result |
	name := self stringOf: self stackTop.
	pathName := self stringOf: (self stackValue: 1).
	
	self successful ifFalse:
		[^self primitiveFail].

	arrayNilOrSymbol := FileDirectory default primLookupEntryIn: pathName name: name.
	arrayNilOrSymbol ifNil:
		[self pop: 3 thenPush: objectMemory nilObject.
		 ^self].
	arrayNilOrSymbol isArray ifFalse:
		["arrayNilOrSymbol ~~ #primFailed ifTrue:
			[self halt]. "
		self transcript show: name, ' NOT FOUND'.
		 ^self primitiveFail].

	result := PharoVM 
		ifTrue:
			[self makeDirEntryName: (arrayNilOrSymbol at: 1) size: (arrayNilOrSymbol at: 1) size
				createDate: (arrayNilOrSymbol at: 2) modDate: (arrayNilOrSymbol at: 3)
				isDir: (arrayNilOrSymbol at: 4) fileSize: (arrayNilOrSymbol at: 5)
				posixPermissions: (arrayNilOrSymbol at: 6 ifAbsent: [8r644]) isSymlink: (arrayNilOrSymbol at: 7 ifAbsent: [false])]
		ifFalse:
			[self makeDirEntryName: (arrayNilOrSymbol at: 1) size: (arrayNilOrSymbol at: 1) size
				createDate: (arrayNilOrSymbol at: 2) modDate: (arrayNilOrSymbol at: 3)
				isDir: (arrayNilOrSymbol at: 4) fileSize: (arrayNilOrSymbol at: 5) ].
	self pop: 3 thenPush: result