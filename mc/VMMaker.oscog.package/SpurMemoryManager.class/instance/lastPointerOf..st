object enumeration
lastPointerOf: objOop 
	"Answer the byte offset of the last pointer field of the given object.
	 Works with CompiledMethods, as well as ordinary objects."
	<api>
	<inline: true>
	| fmt contextSize header |
	fmt := self formatOf: objOop.
	self assert: fmt ~= self forwardedFormat.
	fmt <= self lastPointerFormat ifTrue:
		[(fmt = self indexablePointersFormat
		  and: [self isContextNonImm: objOop]) ifTrue:
			["contexts end at the stack pointer"
			contextSize := coInterpreter fetchStackPointerOf: objOop.
			^CtxtTempFrameStart - 1 + contextSize * self bytesPerOop + self baseHeaderSize].
		^(self numSlotsOf: objOop) - 1 * self bytesPerOop + self baseHeaderSize  "all pointers"].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes"
	header := self methodHeaderOf: objOop.
	^self lastPointerOfMethodHeader: header