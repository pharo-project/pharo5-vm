gc -- compaction
lastPointerWhileForwarding: oop 
	"The given object may have its header word in a forwarding block. Find  
	the offset of the last pointer in the object in spite of this obstacle. "
	| header fmt size methodHeader contextSize |
	<inline: true>
	header := self headerWhileForwardingOf: oop.
	fmt := self formatOfHeader: header.
	fmt <= self lastPointerFormat ifTrue:
		[(fmt = self indexablePointersFormat
		  and: [self isContextHeader: header]) ifTrue:
			["contexts end at the stack pointer"
			contextSize := self nacFetchStackPointerOf: oop.
			self assert: ReceiverIndex + contextSize < (self lengthOf: oop baseHeader: header format: fmt).
			^CtxtTempFrameStart + contextSize * BytesPerWord].
		"do sizeBitsOf: using the header we obtained"
		(header bitAnd: TypeMask) = HeaderTypeSizeAndClass
			ifTrue: [size := (self sizeHeader: oop) bitAnd: AllButTypeMask]
			ifFalse: [size := header bitAnd: SizeMask].
		^size - BaseHeaderSize].
	fmt < self firstCompiledMethodFormat ifTrue: [^ 0]. "no pointers"
	methodHeader := self longAt: oop + BaseHeaderSize.
	^(self literalCountOfHeader: methodHeader) * BytesPerWord + BaseHeaderSize