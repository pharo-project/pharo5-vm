object enumeration
lastPointerOf: objOop recordWeakRoot: recordWeakRoot "<Boolean>"
	"Return the byte offset of the last pointer field of the given object.  
	 Works with CompiledMethods, as well as ordinary objects. 
	 Can be used even when the type bits are not correct.
	 This is a version of lastPointerOf: for markAndTrace:.
	 Already overridden to trace stack pages for the StackInterpreter.
	 Override to ask coInterpreter to determine literalCount of methods."
	| fmt sz header contextSize numOops |
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
				numOops := self nonWeakFieldsOf: objOop. "so nonWeakFieldsOf: may be inlined"
				^numOops * self wordSize].
			"So fmt is 3"
			(self isContextHeader: header) ifTrue:
				[coInterpreter setTraceFlagOnContextsFramesPageIfNeeded: objOop.
				 "contexts end at the stack pointer avoiding having to init fields beyond it"
				 contextSize := coInterpreter fetchStackPointerOf: objOop.
				 self assert: ReceiverIndex + contextSize < (self lengthOf: objOop baseHeader: header format: fmt).
				 ^CtxtTempFrameStart + contextSize * self bytesPerOop]].
		 sz := self sizeBitsOfSafe: objOop.
		 ^sz - self baseHeaderSize  "all pointers" ].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes"
	header := self methodHeaderOf: objOop.
	^self lastPointerOfMethodHeader: header