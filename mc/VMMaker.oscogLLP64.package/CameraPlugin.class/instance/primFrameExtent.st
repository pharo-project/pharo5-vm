primitives
primFrameExtent
	"Answer the frame extent of the given camera, or zero if the camera is not open. The extent is 16 bits of width and height packed into a single integer."

	| cameraNum e |
	<export: true>
	cameraNum := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ 0].

	e := self cCode: 'CameraExtent(cameraNum)'.

	interpreterProxy pop: 2 thenPush: (interpreterProxy integerObjectOf: e).  "pop rcvr & arg, push int result"
	^ 0
