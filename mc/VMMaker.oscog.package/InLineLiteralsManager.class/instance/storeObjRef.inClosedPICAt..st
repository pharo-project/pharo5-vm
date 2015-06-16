garbage collection
storeObjRef: literal inClosedPICAt: address
	<var: #address type: #usqInt>
	<inline: true>
	backEnd storeLiteral: literal beforeFollowingAddress: address