simulation
sqNetworkInit: resolverSemaIndex
	"Simply assume the network is initialized."
	(NetNameResolver classPool at: #HaveNetwork) ifFalse:
		[NetNameResolver initializeNetwork].
	resolverSemaphoreIndex
		ifNil: [resolverSemaphoreIndex := resolverSemaIndex]
		ifNotNil: [self assert: resolverSemaphoreIndex = resolverSemaIndex].
	^0