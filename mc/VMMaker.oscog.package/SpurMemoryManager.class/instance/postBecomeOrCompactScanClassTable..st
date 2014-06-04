become implementation
postBecomeOrCompactScanClassTable: effectsFlags
	"Scan the class table post-become (iff a pointer object or compiled method was becommed),
	 or post-compact.
	 Note that one-way become can cause duplications in the class table.
	 When can these be eliminated?  We use the classTableBitmap to mark classTable entries
	 (not the classes themselves, since marking a class doesn't help in knowing if its index is used).
	 On image load, and during incrememtal scan-mark and full GC, classIndices are marked.
	 We can somehow avoid following classes from the classTable until after this mark phase."
	self assert: self validClassTableRootPages.

	(effectsFlags anyMask: BecamePointerObjectFlag"+BecameCompiledMethodFlag") ifFalse: [^self].
	
	0 to: numClassTablePages - 1 do:
		[:i| | page |
		page := self fetchPointer: i ofObject: hiddenRootsObj.
		self assert: (self isForwarded: page) not.
		0 to: (self numSlotsOf: page) - 1 do:
			[:j| | classOrNil |
			classOrNil := self fetchPointer: j ofObject: page.
			classOrNil ~= nilObj ifTrue:
				[(self isForwarded: classOrNil) ifTrue:
					[classOrNil := self followForwarded: classOrNil.
					 self storePointer: j ofObject: page withValue: classOrNil].
				 self scanClassPostBecome: classOrNil effects: effectsFlags]]]