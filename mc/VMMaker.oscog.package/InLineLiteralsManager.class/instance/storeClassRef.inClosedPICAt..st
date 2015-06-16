garbage collection
storeClassRef: classObj inClosedPICAt: address
	<var: #address type: #usqInt>
	<inline: true>
	cogit backEnd storeLiteral: classObj beforeFollowingAddress: address - cogit backEnd loadLiteralByteSize