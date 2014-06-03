contexts
newActiveContext: aContext
	"Note: internalNewActiveContext: should track changes to this method."

	self storeContextRegisters: activeContext.
	(self oop: aContext isLessThan: youngStart) ifTrue: [ self beRootIfOld: aContext ].
	activeContext := aContext.
	self fetchContextRegisters: aContext.