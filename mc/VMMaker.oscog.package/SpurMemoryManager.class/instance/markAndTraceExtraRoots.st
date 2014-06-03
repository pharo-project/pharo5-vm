gc - global
markAndTraceExtraRoots
	| oop |
	self assert: remapBufferCount = 0.
	"1 to: remapBufferCount do:
		[:i|
		 oop := remapBuffer at: i.
		 ((self isImmediate: oop) or: [self isFreeObject: oop]) ifFalse:
			[self markAndTrace: oop]]."
	1 to: extraRootCount do:
		[:i|
		oop := (extraRoots at: i) at: 0.
		((self isImmediate: oop) or: [self isFreeObject: oop]) ifFalse:
			[self markAndTrace: oop]]