allocation
eeAllocate: byteSize headerSize: hdrSize h1: baseHeader h2: classOop h3: extendedSize doFill: doFill format: format
	"Allocate a new object of the given size and number of header words. (Note: byteSize already includes
	 space for the base header word.) Initialize the header fields of the new object and fill the remainder of
	 the object with the given value.  Will not cause a GC.  This version is for the execution engine"

	| newObj |
	<inline: true>
	<asmLabel: false>
	<var: #i type: 'usqInt'>
	<var: #end type: 'usqInt'>
	newObj := self allocateInterpreterChunk: byteSize + (hdrSize - 1 * BytesPerWord).
	newObj = 0 ifTrue: [^newObj].
	hdrSize = 3 ifTrue:
		[self longAt: newObj put: (extendedSize bitOr: HeaderTypeSizeAndClass).
		 self longAt: newObj + BytesPerWord put: (classOop bitOr: HeaderTypeSizeAndClass).
		 self longAt: newObj + (BytesPerWord*2) put: (baseHeader bitOr: HeaderTypeSizeAndClass).
		 newObj := newObj + (BytesPerWord*2)].

	 hdrSize = 2 ifTrue:
		[self longAt: newObj put: (classOop bitOr: HeaderTypeClass).
		 self longAt: newObj + BytesPerWord put: (baseHeader bitOr: HeaderTypeClass).
		 newObj := newObj + BytesPerWord].

	 hdrSize = 1 ifTrue:
		[self longAt: newObj put: (baseHeader bitOr: HeaderTypeShort)].

	"clear new object"
	doFill ifTrue:
		[| fillWord end i |
		 fillWord := format <= self lastPointerFormat
					ifTrue: [nilObj] "if pointers, fill with nil oop"
					ifFalse: [0].
		 end := newObj + byteSize.
		 i := newObj + BytesPerWord.
		 [i < end] whileTrue:
			[self longAt: i put: fillWord.
			 i := i + BytesPerWord]].

	DoExpensiveAssertionChecks ifTrue:
		[self okayOop: newObj.
		 self oopHasOkayClass: newObj.
		 (self safeObjectAfter: newObj) = freeStart ifFalse:
			[self error: 'allocate bug: did not set header of new oop correctly']].

	^newObj