file primitives
primitiveDirectoryLookup
	| index pathName array result |
	index := self stackIntegerValue: 0.
	pathName := (self stringOf: (self stackValue: 1)).
	
	self successful ifFalse:
		[^self primitiveFail].

	array := FileDirectory default primLookupEntryIn: pathName index: index.

	array == nil ifTrue:
		[self pop: 3 thenPush: objectMemory nilObject.
		^array].
	array == #badDirectoryPath ifTrue:
		["self halt."
		^self primitiveFail].

	PharoVM
		ifTrue: [ 
			result := self makeDirEntryName: (array at: 1) size: (array at: 1) size
				createDate: (array at: 2) modDate: (array at: 3)
				isDir: (array at: 4) fileSize: (array at: 5)
				posixPermissions: (array at: 6) isSymlink: (array at: 7) ]
		ifFalse: [ 
			result := self makeDirEntryName: (array at: 1) size: (array at: 1) size
				createDate: (array at: 2) modDate: (array at: 3)
				isDir: (array at: 4)  fileSize: (array at: 5) ].
	self pop: 3 thenPush: result