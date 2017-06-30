utilities
findClassNamed: classNameString
	| className classNameIndex om |
	(className := self findSymbol: classNameString) ifNil:
		[^nil].
	classNameIndex := simulator classNameIndex.
	(om := simulator objectMemory) allObjectsDo:
		[:obj|
		((om numSlotsOf: obj) > classNameIndex
		 and: [(simulator objCouldBeClassObj: obj)
		 and: [(om fetchPointer: simulator classNameIndex ofObject: obj) = className]]) ifTrue:
			[^obj]].
	^nil