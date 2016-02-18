object access
numPointerSlotsOf: objOop
	"Answer the number of pointer fields in the given object.
	 Works with CompiledMethods, as well as ordinary objects."
	<api>
	<inline: true>
	| fmt contextSize numLiterals header |
	fmt := self formatOf: objOop.
	fmt <= self lastPointerFormat ifTrue:
		[(fmt = self indexablePointersFormat
		  and: [self isContextNonImm: objOop]) ifTrue:
			["contexts end at the stack pointer"
			contextSize := coInterpreter fetchStackPointerOf: objOop.
			^CtxtTempFrameStart + contextSize].
		^self numSlotsOf: objOop  "all pointers"].
	fmt = self forwardedFormat ifTrue: [^1].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes"
	header := self methodHeaderOf: objOop.
	numLiterals := self literalCountOfMethodHeader: header.
	^numLiterals + LiteralStart