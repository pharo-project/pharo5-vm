object enumeration
lastPointerOf: oop 
	"Return the byte offset of the last pointer field of the given object.  
	Works with CompiledMethods, as well as ordinary objects. 
	Can be used even when the type bits are not correct."
	| fmt sz methodHeader header contextSize |
	<inline: true>
	<asmLabel: false>
	header := self baseHeader: oop.
	fmt := self formatOfHeader: header.
	fmt <= 4 ifTrue: [(fmt = 3 and: [self isContextHeader: header])
					ifTrue: ["contexts end at the stack pointer"
						contextSize := self fetchStackPointerOf: oop.
						^ CtxtTempFrameStart + contextSize * BytesPerWord].
				sz := self sizeBitsOfSafe: oop.
				^ sz - BaseHeaderSize  "all pointers"].
	fmt < 12 ifTrue: [^ 0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes:"
	methodHeader := self longAt: oop + BaseHeaderSize.
	^ (methodHeader >> 10 bitAnd: 255) * BytesPerWord + BaseHeaderSize