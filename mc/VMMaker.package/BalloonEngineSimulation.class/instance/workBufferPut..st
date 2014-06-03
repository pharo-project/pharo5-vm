simulation
workBufferPut: wbOop
	interpreterProxy isInterpreterProxy 
		ifTrue:[^super workBufferPut: wbOop].
	workBuffer := ((interpreterProxy firstIndexableField: wbOop) as: BalloonArray) asCArrayAccessor.
	workBufferArray ifNil:
		[workBufferArray := Array new: (interpreterProxy slotSizeOf: wbOop) withAll: 0].
	workBuffer getObject setSimArray: workBufferArray