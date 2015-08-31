weakness and ephemerality
queueEphemeron: anEphemeron
	"Add the ephemeron to the queue and make it non-ephemeral, to avoid subsequent firing.
	 Alas this means that other ephemerons on the same object not identified in this sccavenge
	 or GC will not fire until later.  But that's life."
	self assert: ((self isNonImmediate: anEphemeron)
				and: [(self formatOf: anEphemeron) = self ephemeronFormat]).
	self deny: (self is: anEphemeron onObjStack: mournQueue).
	self push: anEphemeron onObjStack: mournQueue.
	self setFormatOf: anEphemeron to: self nonIndexablePointerFormat