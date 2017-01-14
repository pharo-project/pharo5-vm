debug support
maybeLeakCheckExternalPrimCall: aMethodObj
	"Assert-only check for leaks after external prim calls if checkForLeaks includes the GCCheckPrimCall flag.
	 This is ionly really useful from a low-level C debugger, hence no accessors for checkedPluginName."
	((objectMemory checkForLeaks anyMask: GCCheckPrimCall)
	 and: [(self isExternalPrimitiveCall: aMethodObj)
	 and: [checkedPluginName = (objectMemory fetchPointer: 0 ofObject: (self literal: 0 ofMethod: aMethodObj))]]) ifTrue:
		[objectMemory runLeakCheckerFor: GCCheckPrimCall].
	^true