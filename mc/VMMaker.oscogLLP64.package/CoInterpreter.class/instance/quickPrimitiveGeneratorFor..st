cog jit support
quickPrimitiveGeneratorFor: aQuickPrimitiveIndex
	<api>
	<returnTypeC: 'sqInt (*quickPrimitiveGeneratorFor(sqInt aQuickPrimitiveIndex))(void)'>
	^aQuickPrimitiveIndex
		caseOf: {
			[256] -> [#genQuickReturnSelf].
			[257] -> [#genQuickReturnConst].
			[258] -> [#genQuickReturnConst].
			[259] -> [#genQuickReturnConst].
			[260] -> [#genQuickReturnConst].
			[261] -> [#genQuickReturnConst].
			[262] -> [#genQuickReturnConst].
			[263] -> [#genQuickReturnConst] }
		otherwise: [#genQuickReturnInstVar]