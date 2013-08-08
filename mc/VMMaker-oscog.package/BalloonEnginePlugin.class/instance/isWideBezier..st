testing
isWideBezier: bezier
	^(self isBezier: bezier) and:[self isWide: bezier]