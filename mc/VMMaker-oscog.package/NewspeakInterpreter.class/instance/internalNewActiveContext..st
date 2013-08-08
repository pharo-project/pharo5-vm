contexts
internalNewActiveContext: aContext
	"The only difference between this method and newActiveContext: is that this method uses internal context registers."
	<inline: true>

	self internalStoreContextRegisters: activeContext.
	(aContext < youngStart) ifTrue: [ self beRootIfOld: aContext ].
	activeContext := aContext.
	self internalFetchContextRegisters: aContext.