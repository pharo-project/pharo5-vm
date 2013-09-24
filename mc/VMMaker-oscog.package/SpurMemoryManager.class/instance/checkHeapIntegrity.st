debug support
checkHeapIntegrity
	"Perform an integrity/leak check using the heapMap.  Assume
	 clearLeakMapAndMapAccessibleObjects has set a bit at each
	 object's header.  Scan all objects in the heap checking that every
	 pointer points to a header.  Scan the rootTable, remapBuffer and
	 extraRootTable checking that every entry is a pointer to a header.
	 Check that the number of roots is correct and that all rootTable
	 entries have their rootBit set. Answer if all checks pass."
	| prevObj prevPrevObj ok numRememberedRootsInHeap |
	<inline: false>
	ok := true.
	numRememberedRootsInHeap := 0.
	self allHeapEntitiesDo:
		[:obj| | containsYoung fieldOop classIndex classOop |
		(self isFreeObject: obj) ifFalse:
			[containsYoung := false.
			 (self isRemembered: obj) ifTrue:
				[numRememberedRootsInHeap := numRememberedRootsInHeap + 1.
				 (scavenger isInRememberedTable: obj) ifFalse:
					[coInterpreter print: 'remembered object '; printHex: obj; print: ' is not in remembered table'; cr.
					 self eek.
					 ok := false]].
			 (self isForwarded: obj)
				ifTrue:
					[fieldOop := self fetchPointer: 0 ofMaybeForwardedObject: obj.
					 (heapMap heapMapAtWord: (self pointerForOop: fieldOop)) = 0 ifTrue:
						[coInterpreter print: 'object leak in forwarder '; printHex: obj; print: ' to unmapped '; printHex: fieldOop; cr.
						 self eek.
						 ok := false].
					 (self isYoung: fieldOop) ifTrue:
						[containsYoung := true]]
				ifFalse:
					[classOop := self classAtIndex: (classIndex := self classIndexOf: obj).
					 (classOop isNil or: [classOop = nilObj]) ifTrue:
						[coInterpreter print: 'object leak in '; printHex: obj; print: ' invalid class index '; printHex: classIndex; print: ' -> '; print: (classOop ifNil: ['nil'] ifNotNil: ['nilObj']); cr.
						 self eek.
						 ok := false].
					 self baseHeaderSize to: (self lastPointerOf: obj) by: BytesPerOop do:
						[:ptr|
						 fieldOop := self longAt: obj + ptr.
						 (self isNonImmediate: fieldOop) ifTrue:
							[| fi |
							 fi := ptr - self baseHeaderSize / self wordSize.
							 (fieldOop bitAnd: self wordSize - 1) ~= 0
								ifTrue:
									[coInterpreter print: 'misaligned oop in '; printHex: obj; print: ' @ '; printNum: fi; print: ' = '; printHex: fieldOop; cr.
									 self eek.
									 ok := false]
								ifFalse:
									[(heapMap heapMapAtWord: (self pointerForOop: fieldOop)) = 0 ifTrue:
										[coInterpreter print: 'object leak in '; printHex: obj; print: ' @ '; printNum: fi; print: ' = '; printHex: fieldOop; cr.
										 self eek.
										 ok := false].
									 (self isYoung: fieldOop) ifTrue:
										[containsYoung := true]]]]].
					(containsYoung and: [(self isYoung: obj) not]) ifTrue:
						[(self isRemembered: obj) ifFalse:
							[coInterpreter print: 'unremembered object '; printHex: obj; print: ' contains young oop(s)'; cr.
							 self eek.
							 ok := false]]].
		prevPrevObj := prevObj.
		prevObj := obj].
	numRememberedRootsInHeap ~= scavenger rememberedSetSize ifTrue:
		[coInterpreter
			print: 'root count mismatch. #heap roots ';
			printNum: numRememberedRootsInHeap;
			print: '; #roots ';
			printNum: scavenger rememberedSetSize;
			cr.
		"But the system copes with overflow..."
		self flag: 'no support for remembered set overflow yet'.
		"ok := rootTableOverflowed and: [needGCFlag]"].
	scavenger rememberedSetWithIndexDo:
		[:obj :i|
		(obj bitAnd: self wordSize - 1) ~= 0
			ifTrue:
				[coInterpreter print: 'misaligned oop in rootTable @ '; printNum: i; print: ' = '; printHex: obj; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0
					ifTrue:
						[coInterpreter print: 'object leak in rootTable @ '; printNum: i; print: ' = '; printHex: obj; cr.
						 self eek.
						 ok := false]
					ifFalse:
						[(self isYoung: obj) ifTrue:
							[coInterpreter print: 'non-root in rootTable @ '; printNum: i; print: ' = '; printHex: obj; cr.
							 self eek.
							 ok := false]]]].
	self flag: 'no support for remap buffer yet'.
	"1 to: remapBufferCount do:
		[:ri|
		obj := remapBuffer at: ri.
		(obj bitAnd: self wordSize - 1) ~= 0
			ifTrue:
				[coInterpreter print: 'misaligned remapRoot @ '; printNum: ri; print: ' = '; printHex: obj; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0
					ifTrue:
						[coInterpreter print: 'object leak in remapRoots @ '; printNum: ri; print: ' = '; printHex: obj; cr.
						 self eek.
						 ok := false]]]."
	self flag: 'no support for extraRoots yet'.
	"1 to: extraRootCount do:
		[:ri|
		obj := (extraRoots at: ri) at: 0.
		(obj bitAnd: self wordSize - 1) ~= 0
			ifTrue:
				[coInterpreter print: 'misaligned extraRoot @ '; printNum: ri; print: ' => '; printHex: obj; cr.
				 self eek.
				 ok := false]
			ifFalse:
				[(heapMap heapMapAtWord: (self pointerForOop: obj)) = 0
					ifTrue:
						[coInterpreter print: 'object leak in extraRoots @ '; printNum: ri; print: ' => '; printHex: obj; cr.
						 self eek.
						 ok := false]]]."
	^ok