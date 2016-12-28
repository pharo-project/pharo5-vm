private
numPointerSlotsWhileCompactingOf: obj withFormat: fmt savedFirstFieldPointer: firstFieldPtrOrNil
	"This is a version of SpurMemoryManager>>numPointerSlotsOf: that deals with the
	 possibility of obj being a CompiledMethod whose header is in savedFirstFieldsSpace.
	 Answer the number of pointer fields in the given object.
	 Works with CompiledMethods, as well as ordinary objects."
	<inline: true>
	| contextSize numLiterals header |
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
	self assert: firstFieldPtrOrNil notNil == (self isMobile: obj).
	header := firstFieldPtrOrNil
				ifNil: [manager methodHeaderOf: obj]
				ifNotNil: [manager methodHeaderFromSavedFirstField: (manager longAt: firstFieldPtrOrNil)].
	numLiterals := manager literalCountOfMethodHeader: header.
	^numLiterals + LiteralStart