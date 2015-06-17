garbage collection
storeObjRef: literal inClosedPICAt: address
	<var: #address type: #usqInt>
	<inline: true>
	cogit backEnd storeLiteral: literal beforeFollowingAddress: address