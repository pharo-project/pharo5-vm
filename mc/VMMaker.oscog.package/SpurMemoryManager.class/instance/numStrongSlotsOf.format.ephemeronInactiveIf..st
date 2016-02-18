object access
numStrongSlotsOf: objOop format: fmt ephemeronInactiveIf: criterion
	"Answer the number of strong pointer fields in the given object.
	 Works with CompiledMethods, as well as ordinary objects."
	<var: 'criterion' declareC: 'int (*criterion)(sqInt key)'>
	<inline: true>
	| numSlots  contextSize numLiterals header |
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
			[^self fixedFieldsOfClass: (self fetchClassOfNonImm: objOop)].
		 self assert: fmt = self ephemeronFormat.
		 ^(self perform: criterion with: (self keyOfEphemeron: objOop))
			ifTrue: [numSlots]
			ifFalse: [0]].
	fmt = self forwardedFormat ifTrue: [^1].
	fmt < self firstCompiledMethodFormat ifTrue: [^0]. "no pointers"

	"CompiledMethod: contains both pointers and bytes"
	header := self methodHeaderOf: objOop.
	numLiterals := self literalCountOfMethodHeader: header.
	^numLiterals + LiteralStart