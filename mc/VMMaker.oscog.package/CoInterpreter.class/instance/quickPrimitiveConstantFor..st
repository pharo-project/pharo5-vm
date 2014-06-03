cog jit support
quickPrimitiveConstantFor: aQuickPrimitiveIndex
	<api>
	^aQuickPrimitiveIndex caseOf: {
		[257] -> [objectMemory trueObject].
		[258] -> [objectMemory falseObject].
		[259] -> [objectMemory nilObject].
		[260] -> [ConstMinusOne].
		[261] -> [ConstZero].
		[262] -> [ConstOne].
		[263] -> [ConstTwo] }