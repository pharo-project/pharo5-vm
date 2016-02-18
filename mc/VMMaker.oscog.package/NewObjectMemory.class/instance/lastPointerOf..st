object enumeration
lastPointerOf: objOop 
	"Return the byte offset of the last pointer field of the given object.  
	 Can be used even when the type bits are not correct.
	 Works with CompiledMethods, as well as ordinary objects."
	<api>
	<inline: true>
	| fmt header contextSize |
	header := self baseHeader: objOop.
	fmt := self formatOfHeader: header.
	fmt <= self lastPointerFormat ifTrue:
		[(fmt = self indexablePointersFormat
		  and: [self isContextHeader: header]) ifTrue:
			["contexts end at the stack pointer"
			contextSize := coInterpreter fetchStackPointerOf: objOop.
			^CtxtTempFrameStart + contextSize * self bytesPerOop].
		^(self sizeBitsOfSafe: objOop) - self baseHeaderSize  "all pointers"].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes"
	header := self methodHeaderOf: objOop.
	^self lastPointerOfMethodHeader: header