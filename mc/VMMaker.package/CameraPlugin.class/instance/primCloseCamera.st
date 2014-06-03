primitives
primCloseCamera
	"Close the camera. Do nothing if it was not open."

	| cameraNum |
	<export: true>
	cameraNum := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ 0].

	self cCode: 'CameraClose(cameraNum)'.

	interpreterProxy pop: 1.  "pop arg, leave rcvr on stack"
	^ 0
