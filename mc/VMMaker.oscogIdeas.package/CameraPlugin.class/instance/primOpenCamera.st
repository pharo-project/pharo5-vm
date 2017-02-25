primitives
primOpenCamera
	"Open a camera. Takes one argument, the index of the device to open."

	| cameraNum desiredFrameWidth desiredFrameHeight ok |
	<export: true>

	cameraNum := interpreterProxy stackIntegerValue: 2.
	desiredFrameWidth := interpreterProxy stackIntegerValue: 1.
	desiredFrameHeight := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ 0].

	ok := self cCode: 'CameraOpen(cameraNum, desiredFrameWidth, desiredFrameHeight)'.
	ok = 0 ifTrue: [
		interpreterProxy success: false.
		^ 0].

	interpreterProxy pop: 3.  "pop args, leave rcvr on stack"
	^ 0
