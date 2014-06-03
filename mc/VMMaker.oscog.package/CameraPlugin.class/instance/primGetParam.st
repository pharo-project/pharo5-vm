primitives
primGetParam
	"Answer the given integer parameter of the given camera."

	| cameraNum paramNum result |
	<export: true>
	cameraNum := interpreterProxy stackIntegerValue: 1.
	paramNum := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ 0].

	result := self cCode: 'CameraGetParam(cameraNum, paramNum)'.

	interpreterProxy pop: 3 thenPush: (interpreterProxy integerObjectOf: result).  "pop rcvr & args, push int result"
	^ 0
