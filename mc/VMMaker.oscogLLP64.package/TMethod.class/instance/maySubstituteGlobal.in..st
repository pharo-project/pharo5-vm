inlining support
maySubstituteGlobal: globalVar in: aCodeGen
	"We can substitute globalVar into this method provided globalVar is only read, not written."

	writtenToGlobalVarsCache = nil ifTrue:
		[self computePossibleSideEffectsInto: (Set new: 50) visited: (Set new: 50) in: aCodeGen].
	^(writtenToGlobalVarsCache includes: globalVar) not