primitives
primitiveInitializeNetwork: resolverSemaIndex

	| err |
	self primitive: 'primitiveInitializeNetwork'
		parameters: #(SmallInteger).
	err := self sqNetworkInit: resolverSemaIndex.
	interpreterProxy success: err = 0