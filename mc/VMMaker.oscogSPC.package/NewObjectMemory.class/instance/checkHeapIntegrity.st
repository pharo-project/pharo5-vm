memory access
checkHeapIntegrity
	"Perform an integrity/leak check using the heapMap.  Assume
	 clearLeakMapAndMapAccessibleObjects has set a bit at each
	 object's header.  Scan all objects in the heap checking that every
	 pointer points to a header.  Scan the rootTable, remapBuffer and
	 extraRootTable checking that every entry is a pointer to a header.
	 Check that the number of roots is correct and that all rootTable
	 entries have their rootBit set. Answer if all checks pass."
	| ok obj sz hdr fmt fi fieldOop numRootsInHeap |
	<inline: false>
	ok := true.
	numRootsInHeap := 0.
	obj := self firstObject.
	[self oop: obj isLessThan: self startOfFreeSpace] whileTrue:
		[(self isFreeObject: obj)
			ifTrue:
				[sz := self sizeOfFree: obj]
			ifFalse:
				[hdr := self baseHeader: obj.
				 (self isYoungRootHeader: hdr) ifTrue:
					[numRootsInHeap := numRootsInHeap + 1].
				 (self compactClassIndexOfHeader: hdr) = 0 ifTrue:
					[fieldOop := (self classHeader: obj) bitAnd: AllButTypeMask.
					 ((self isIntegerObject: fieldOop)
					   or: [(heapMap heapMapAtWord: (self pointerForOop: fieldOop)) = 0]) ifTrue:
						[self print: 'object leak in '; printHex: obj; print: ' class = '; printHex: fieldOop; cr.
						 self eek.
						 ok := false]].
				 fmt := self formatOfHeader: hdr.
				 (fmt <= 4 "pointers" or: [fmt >= 12 "compiled method"]) ifTrue:
					[fmt >= 12
						ifTrue: [fi := (self literalCountOf: obj) + LiteralStart]
						ifFalse: [(fmt = 3 and: [self isContextHeader: hdr])
									ifTrue: [fi := CtxtTempFrameStart + (coInterpreter fetchStackPointerOf: obj)]
									ifFalse: [fi := self lengthOf: obj]].
					[(fi := fi - 1) >= 0] whileTrue:
						[fieldOop := self fetchPointer: fi ofObject: obj.
						 (self isNonIntegerObject: fieldOop) ifTrue:
							[(fieldOop bitAnd: self wordSize - 1) ~= 0
								ifTrue:
									[self print: 'misaligned oop in '; printHex: obj; print: ' @ '; printNum: fi; print: ' = '; printHex: fieldOop; cr.
									 self eek.
									 ok := false]
								ifFalse:
									[(heapMap heapMapAtWord: (self pointerForOop: fieldOop)) = 0 ifTrue:
										[self print: 'object leak in '; printHex: obj; print: ' @ '; printNum: fi; print: ' = '; printHex: fieldOop; cr.
										 self eek.
										 ok := false]]]]].
				 sz := self sizeBitsOf: obj].
		 obj := self oopFromChunk: obj + sz].
	numRootsInHeap ~= rootTableCount ifTrue:
		[self print: 'root count mismatch. #heap roots '; printNum: numRootsInHeap; print: '; #roots '; printNum: rootTableCount; cr.
		"But the system copes with overflow..."
		ok := rootTableOverflowed and: [needGCFlag]].
	1 to: rootTableCount do:
		[:ri|
		obj := rootTable at: ri.
		(obj bitAnd: self wordSize - 1) ~= 0
			ifTrue:
				[self print: 'misaligned oop in rootTable @ '; printNum: ri; print: ' = '; printHex: obj; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0
					ifTrue:
						[self print: 'object leak in rootTable @ '; printNum: ri; print: ' = '; printHex: obj; cr.
						 self eek.
						 ok := false]
					ifFalse:
						[hdr := self baseHeader: obj.
						 (self isYoungRootHeader: hdr) ifFalse:
							[self print: 'non-root in rootTable @ '; printNum: ri; print: ' = '; printHex: obj; cr.
							 self eek.
							 ok := false]]]].
	1 to: remapBufferCount do:
		[:ri|
		obj := remapBuffer at: ri.
		(obj bitAnd: self wordSize - 1) ~= 0
			ifTrue:
				[self print: 'misaligned remapRoot @ '; printNum: ri; print: ' = '; printHex: obj; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0
					ifTrue:
						[self print: 'object leak in remapRoots @ '; printNum: ri; print: ' = '; printHex: obj; cr.
						 self eek.
						 ok := false]]].
	1 to: extraRootCount do:
		[:ri|
		obj := (extraRoots at: ri) at: 0.
		(obj bitAnd: self wordSize - 1) ~= 0
			ifTrue:
				[self print: 'misaligned extraRoot @ '; printNum: ri; print: ' => '; printHex: obj; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0
					ifTrue:
						[self print: 'object leak in extraRoots @ '; printNum: ri; print: ' => '; printHex: obj; cr.
						 self eek.
						 ok := false]]].
	^ok