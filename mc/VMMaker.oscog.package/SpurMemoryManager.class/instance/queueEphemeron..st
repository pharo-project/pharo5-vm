weakness and ephemerality
queueEphemeron: anEphemeron
	self assert: ((self isNonImmediate: anEphemeron)
				and: [(self formatOf: anEphemeron) = self ephemeronFormat]).
	self push: anEphemeron onObjStack: ephemeronQueue