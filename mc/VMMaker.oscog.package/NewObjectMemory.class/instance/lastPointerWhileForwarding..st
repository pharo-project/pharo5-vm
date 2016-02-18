gc -- compaction
lastPointerWhileForwarding: objOop 
	"The given object may have its header word in a forwarding block. Find  
	 the offset of the last pointer in the object in spite of this obstacle."
	| header fmt size contextSize |
	<inline: true>
	header := self headerWhileForwardingOf: objOop.
	fmt := self formatOfHeader: header.
	fmt <= self lastPointerFormat ifTrue:
		[(fmt = self indexablePointersFormat
		  and: [self isContextHeader: header]) ifTrue:
			["contexts end at the stack pointer"
			 contextSize := coInterpreter nacFetchStackPointerOf: objOop.
			 self assert: ReceiverIndex + contextSize < (self lengthOf: objOop baseHeader: header format: fmt).
			 ^CtxtTempFrameStart + contextSize * self bytesPerOop].
		 "do sizeBitsOf: using the header we obtained"
		 size := (header bitAnd: TypeMask) = HeaderTypeSizeAndClass
					ifTrue: [(self sizeHeader: objOop) bitAnd: AllButTypeMask]
					ifFalse: [header bitAnd: SizeMask].
		 ^size - self baseHeaderSize].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"
	"CompiledMethod: contains both pointers and bytes"
	self assert: (self isCompiledMethodHeader: header).
	header := self noCheckMethodHeaderOf: objOop.
	^self lastPointerOfMethodHeader: header