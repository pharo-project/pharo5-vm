gc -- compaction
lastPointerWhileForwarding: oop 
	"The given object may have its header word in a forwarding block. Find  
	 the offset of the last pointer in the object in spite of this obstacle."
	| header fmt size contextSize numLiterals |
	<inline: true>
	header := self headerWhileForwardingOf: oop.
	fmt := self formatOfHeader: header.
	fmt <= self lastPointerFormat ifTrue:
		[(fmt = self indexablePointersFormat
		  and: [self isContextHeader: header]) ifTrue:
			["contexts end at the stack pointer"
			 contextSize := coInterpreter nacFetchStackPointerOf: oop.
			 self assert: ReceiverIndex + contextSize < (self lengthOf: oop baseHeader: header format: fmt).
			 ^CtxtTempFrameStart + contextSize * BytesPerOop].
		 "do sizeBitsOf: using the header we obtained"
		 size := (header bitAnd: TypeMask) = HeaderTypeSizeAndClass
					ifTrue: [(self sizeHeader: oop) bitAnd: AllButTypeMask]
					ifFalse: [header bitAnd: SizeMask].
		 ^size - BaseHeaderSize].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"
	"CompiledMethod: contains both pointers and bytes"
	self assert: (header bitAnd: MarkBit) = 0.
	numLiterals := coInterpreter literalCountOf: oop.
	^numLiterals + LiteralStart * BytesPerOop