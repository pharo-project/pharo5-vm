testing
isFill: fill
	^(self isFillColor: fill) or:[self isRealFill: fill]