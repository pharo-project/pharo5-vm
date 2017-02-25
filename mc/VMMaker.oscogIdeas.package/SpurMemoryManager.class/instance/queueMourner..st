weakness and ephemerality
queueMourner: anEphemeronOrWeakArray
	"Add the ephemeron to the queue and make it non-ephemeral, to avoid subsequent firing.
	 Alas this means that other ephemerons on the same object not identified in this sccavenge
	 or GC will not fire until later.  But that's life."
	self assert: ((self isNonImmediate: anEphemeronOrWeakArray)
				and: [(self formatOf: anEphemeronOrWeakArray) = self ephemeronFormat
				   or: [(self formatOf: anEphemeronOrWeakArray) = self weakArrayFormat]]).
	self deny: ((self formatOf: anEphemeronOrWeakArray) = self ephemeronFormat
				and: [self is: anEphemeronOrWeakArray onObjStack: mournQueue]).
	self ensureRoomOnObjStackAt: MournQueueRootIndex.
	self push: anEphemeronOrWeakArray onObjStack: mournQueue