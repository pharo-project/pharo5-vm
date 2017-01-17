testing
isRealMethod
	^(self definedAsMacro or: [self isStructAccessor]) not