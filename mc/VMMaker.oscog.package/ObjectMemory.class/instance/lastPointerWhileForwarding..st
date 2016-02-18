gc -- compaction
lastPointerWhileForwarding: objOop 
	"The given object may have its header word in a forwarding block. Find  
	the offset of the last pointer in the object in spite of this obstacle. "
	| header fmt size contextSize |
	<inline: true>
	header := self headerWhileForwardingOf: objOop.
	fmt := self formatOfHeader: header.
	fmt <= self lastPointerFormat ifTrue:
		[(fmt = self indexablePointersFormat
		  and: [self isContextHeader: header]) ifTrue:
			["contexts end at the stack pointer"
			contextSize := self nacFetchStackPointerOf: objOop.
			self assert: ReceiverIndex + contextSize < (self lengthOf: objOop baseHeader: header format: fmt).
			^CtxtTempFrameStart + contextSize * self wordSize].
		"do sizeBitsOf: using the header we obtained"
		(header bitAnd: TypeMask) = HeaderTypeSizeAndClass
			ifTrue: [size := (self sizeHeader: objOop) bitAnd: AllButTypeMask]
			ifFalse: [size := header bitAnd: SizeMask].
		^size - self baseHeaderSize].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"
	"CompiledMethod: contains both pointers and bytes"
	self assert: (self isCompiledMethodHeader: header).
	header := self noCheckMethodHeaderOf: objOop.
	^self lastPointerOfMethodHeader: header