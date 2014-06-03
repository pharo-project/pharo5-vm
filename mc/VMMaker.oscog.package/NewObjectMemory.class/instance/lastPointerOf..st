object enumeration
lastPointerOf: oop 
	"Return the byte offset of the last pointer field of the given object.  
	 Can be used even when the type bits are not correct.
	 Works with CompiledMethods, as well as ordinary objects."
	<api>
	<inline: true>
	<asmLabel: false>
	| fmt header contextSize numLiterals |
	header := self baseHeader: oop.
	fmt := self formatOfHeader: header.
	fmt <= self lastPointerFormat ifTrue:
		[(fmt = self indexablePointersFormat
		  and: [self isContextHeader: header]) ifTrue:
			["contexts end at the stack pointer"
			contextSize := coInterpreter fetchStackPointerOf: oop.
			^CtxtTempFrameStart + contextSize * BytesPerOop].
		^(self sizeBitsOfSafe: oop) - BaseHeaderSize  "all pointers"].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes"
	numLiterals := coInterpreter literalCountOf: oop.
	^numLiterals + LiteralStart * BytesPerOop