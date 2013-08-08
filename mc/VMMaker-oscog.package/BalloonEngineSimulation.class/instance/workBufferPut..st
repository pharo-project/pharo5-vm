simulation
workBufferPut: wbOop
	interpreterProxy isInterpreterProxy 
		ifTrue:[^super workBufferPut: wbOop].
	workBuffer := ((interpreterProxy firstIndexableField: wbOop) as: BalloonArray) asCArrayAccessor.
	workBufferArray ifNil:
		[workBufferArray := Array new: (interpreterProxy slotSizeOf: wbOop)].
	workBuffer getObject setSimArray: workBufferArray