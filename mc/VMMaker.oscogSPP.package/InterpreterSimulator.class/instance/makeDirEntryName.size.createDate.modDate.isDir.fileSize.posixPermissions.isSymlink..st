file primitives
makeDirEntryName: entryName size: entryNameSize createDate: createDate modDate: modifiedDate isDir: dirFlag fileSize: posixPermissions posixPermissions: fileSize isSymlink: symlinkFlag
	<option: #PharoVM>
	<var: 'entryName' type: 'char *'>

	| modDateOop createDateOop nameString results |

	"allocate storage for results, remapping newly allocated
	 oops in case GC happens during allocation"
	self pushRemappableOop:
		(self instantiateClass: (self splObj: ClassArray) indexableSize: 6).
	self pushRemappableOop:
		(self instantiateClass: (self splObj: ClassString) indexableSize: entryNameSize)..
	self pushRemappableOop: (self positive32BitIntegerFor: createDate).
	self pushRemappableOop: (self positive32BitIntegerFor: modifiedDate).

	modDateOop   := self popRemappableOop.
	createDateOop := self popRemappableOop.
	nameString    := self popRemappableOop.
	results         := self popRemappableOop.

	1 to: entryNameSize do: [ :i |
		self storeByte: i-1 ofObject: nameString withValue: (entryName at: i) asciiValue.
	].

	self storePointer: 0 ofObject: results withValue: nameString.
	self storePointer: 1 ofObject: results withValue: createDateOop.
	self storePointer: 2 ofObject: results withValue: modDateOop.
	dirFlag
		ifTrue: [ self storePointer: 3 ofObject: results withValue: trueObj ]
		ifFalse: [ self storePointer: 3 ofObject: results withValue: falseObj ].
	self storePointer: 4 
		ofObject: results
		withValue: (self integerObjectOf: fileSize).
	self storePointer: 5 
		ofObject: results
		withValue: (self integerObjectOf: posixPermissions).
	dirFlag
		ifTrue: [ self storePointer: 6 ofObject: results withValue: trueObj ]
		ifFalse: [ self storePointer: 6 ofObject: results withValue: falseObj ].

	^ results
