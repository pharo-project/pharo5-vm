translation
mustBeGlobal: var
	"Answer if a variable must be global and exported.  Used for inst vars that are accessed from VM support code."

	^(ObjectMemory mustBeGlobal: var)
	   or: [#('interpreterProxy' 'interpreterVersion' 'inIOProcessEvents'
			'deferDisplayUpdates' 'extraVMMemory' 'showSurfaceFn'
			'breakSelector' 'breakSelectorLength' 'sendTrace') includes: var]