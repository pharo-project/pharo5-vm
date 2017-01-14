private
numPointerSlotsWhileCompactingOf: obj withFormat: fmt savedFirstFieldPointer: firstFieldPtr
	"This is a version of SpurMemoryManager>>numPointerSlotsOf: that deals with the
	 possibility of obj being a CompiledMethod whose header is in savedFirstFieldsSpace.
	 Answer the number of pointer fields in the given object.
	 Works with CompiledMethods, as well as ordinary objects."
	<inline: true>
	| contextSize numLiterals header |
	self assert: (firstFieldPtr notNil and: [self isMobile: obj]).
	fmt <= manager lastPointerFormat ifTrue:
		[(fmt = manager indexablePointersFormat
		  and: [manager isContextNonImm: obj]) ifTrue:
			["contexts end at the stack pointer"
			contextSize := coInterpreter fetchStackPointerOf: obj.
			^CtxtTempFrameStart + contextSize].
		^manager numSlotsOf: obj  "all pointers"].
	self deny: fmt = manager forwardedFormat.
	fmt < manager firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes"
	header := manager methodHeaderFromSavedFirstField: (manager longAt: firstFieldPtr).
	numLiterals := manager literalCountOfMethodHeader: header.
	^numLiterals + LiteralStart