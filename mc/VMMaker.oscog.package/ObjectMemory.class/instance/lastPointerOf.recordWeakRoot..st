gc -- mark and sweep
lastPointerOf: objOop recordWeakRoot: recordWeakRoot "<Boolean>"
	"Return the byte offset of the last pointer field of the given object.  
	 Works with CompiledMethods, as well as ordinary objects. 
	 Can be used even when the type bits are not correct.
	 This is a version of lastPointerOf: for markAndTrace:."
	| fmt sz header contextSize |
	<inline: true>
	header := self baseHeader: objOop.
	fmt := self formatOfHeader: header.
	fmt <= self lastPointerFormat ifTrue:
		[fmt >= self indexablePointersFormat ifTrue:
			[fmt = self lastPointerFormat ifTrue:
				[(recordWeakRoot and: [weakRootCount >= 0]) ifTrue:
					["And remember as weak root"
					 (weakRootCount := weakRootCount + 1) <= WeakRootTableSize ifFalse:
						[self error: 'weakRoots table overflow'].
					 weakRoots at: weakRootCount put: objOop].
				"Do not trace the object's indexed fields if it's a weak class"
				^(self nonWeakFieldsOf: objOop) * self bytesPerOop].
			"So fmt is 3"
			(self isContextHeader: header) ifTrue:
				["contexts end at the stack pointer avoiding having to init fields beyond it"
				 contextSize := self fetchStackPointerOf: objOop.
				 ^CtxtTempFrameStart + contextSize * self bytesPerOop]].
		 sz := self sizeBitsOfSafe: objOop.
		 ^sz - self baseHeaderSize  "all pointers"].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes:"
	header := self methodHeaderOf: objOop.
	^self lastPointerOfMethodHeader: header