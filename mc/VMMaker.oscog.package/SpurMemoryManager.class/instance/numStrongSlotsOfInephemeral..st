object access
numStrongSlotsOfInephemeral: objOop
	"Answer the number of strong pointer fields in the given object,
	 which is .expected not to be an active ephemeron.
	 Works with CompiledMethods, as well as ordinary objects."
	<inline: true>
	| fmt numSlots  contextSize numLiterals header |
	fmt := self formatOf: objOop.
	self assert: (fmt ~= self ephemeronFormat or: [self isMarked: (self keyOfEphemeron: objOop)]).
	fmt <= self lastPointerFormat ifTrue:
		[numSlots := self numSlotsOf: objOop.
		 fmt <= self arrayFormat ifTrue:
			[^numSlots].
		 fmt = self indexablePointersFormat ifTrue:
			[(self isContextNonImm: objOop) ifTrue:
				[coInterpreter setTraceFlagOnContextsFramesPageIfNeeded: objOop.
				 "contexts end at the stack pointer"
				 contextSize := coInterpreter fetchStackPointerOf: objOop.
				 ^CtxtTempFrameStart + contextSize].
			 ^numSlots].
		 fmt = self weakArrayFormat ifTrue:
			[^self fixedFieldsOfClass: (self fetchClassOfNonImm: objOop)]].
	fmt = self forwardedFormat ifTrue: [^1].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes"
	header := self methodHeaderOf: objOop.
	numLiterals := self literalCountOfMethodHeader: header.
	^numLiterals + LiteralStart