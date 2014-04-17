object enumeration
lastPointerOf: oop 
	"Return the byte offset of the last pointer field of the given object.  
	 Can be used even when the type bits are not correct.
	 Works with CompiledMethods, as well as ordinary objects."
	| fmt header contextSize numLiterals |
	<inline: true>
	<asmLabel: false>
	header := self baseHeader: oop.
	fmt := self formatOfHeader: header.
	fmt <= 4 ifTrue:
		[(fmt = 3
		  and: [self isContextHeader: header]) ifTrue:
			["contexts end at the stack pointer"
			contextSize := coInterpreter fetchStackPointerOf: oop.
			^CtxtTempFrameStart + contextSize * BytesPerWord].
		^(self sizeBitsOfSafe: oop) - BaseHeaderSize  "all pointers"].
	fmt < 12 ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes"
	numLiterals := coInterpreter literalCountOf: oop.
	^numLiterals * BytesPerWord + BaseHeaderSize