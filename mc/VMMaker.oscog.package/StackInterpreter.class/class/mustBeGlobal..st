translation
mustBeGlobal: var
	"Answer if a variable must be global and exported.  Used for inst vars that are accessed from VM support code."

	^(super mustBeGlobal: var)
	   or: [(self objectMemoryClass mustBeGlobal: var)
	   or: [(#('interpreterProxy' 'interpreterVersion' 'inIOProcessEvents'
			'deferDisplayUpdates' 'extraVMMemory'
			'showSurfaceFn' 'displayBits' 'displayWidth' 'displayHeight' 'displayDepth'
			'desiredNumStackPages' 'desiredEdenBytes'
			'breakSelector' 'breakSelectorLength' 'sendTrace' 'checkAllocFiller' 'checkedPluginName'
			'suppressHeartbeatFlag' 'debugCallbackInvokes' 'debugCallbackPath' 'debugCallbackReturns') includes: var)
	   or: [ "This allows slow machines to define bytecodeSetSelector as 0
			to avoid the interpretation overhead."
			MULTIPLEBYTECODESETS not and: [var = 'bytecodeSetSelector']]]]