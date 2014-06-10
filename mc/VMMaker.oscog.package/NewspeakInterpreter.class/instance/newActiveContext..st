contexts
newActiveContext: aContext
	"Note: internalNewActiveContext: should track changes to this method."

	self storeContextRegisters: activeContext.
	(aContext < youngStart) ifTrue: [ self beRootIfOld: aContext ].
	activeContext := aContext.
	self fetchContextRegisters: aContext.