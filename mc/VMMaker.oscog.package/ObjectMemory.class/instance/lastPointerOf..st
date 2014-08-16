object enumeration
lastPointerOf: objOop 
	"Return the byte offset of the last pointer field of the given object.  
	Works with CompiledMethods, as well as ordinary objects. 
	Can be used even when the type bits are not correct."
	<api>
	<inline: true>
	<asmLabel: false>
	| fmt sz header contextSize |
	header := self baseHeader: objOop.
	fmt := self formatOfHeader: header.
	fmt <= self lastPointerFormat ifTrue:
		[(fmt = self indexablePointersFormat
		  and: [self isContextHeader: header])
					ifTrue: ["contexts end at the stack pointer"
						contextSize := self fetchStackPointerOf: objOop.
						^ CtxtTempFrameStart + contextSize * BytesPerWord].
				sz := self sizeBitsOfSafe: objOop.
				^sz - BaseHeaderSize "all pointers"].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes:"
	header := self methodHeaderOf: objOop.
	^self lastPointerOfMethodHeader: header