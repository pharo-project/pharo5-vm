cog jit support
ceCheckProfileTick
	"Check if the profile timer has expired and if so take a sample.
	 If the primitive has failed sample the profileMethod as nil.
	 As a courtesy to compileInterpreterPrimitive: map NULL to nilObj."
	<api>
	newMethod ifNil: [newMethod := objectMemory nilObject].
	self cCode: [] inSmalltalk:
		[newMethod = 0 ifTrue: [newMethod := objectMemory nilObject]].
	self checkProfileTick: newMethod