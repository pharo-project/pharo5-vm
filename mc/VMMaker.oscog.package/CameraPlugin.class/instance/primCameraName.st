primitives
primCameraName
	"Get the name for the camera with the given number. Fail if the camera number is greater than the number of available cameras."

	| cameraNum nameStr count resultOop dst |
	<export: true>
	<var: 'nameStr' declareC: 'char* nameStr'>
	<var: 'dst' declareC: 'char* dst'>

	cameraNum := interpreterProxy stackIntegerValue: 0.
	interpreterProxy failed ifTrue: [^ 0].

	nameStr := self cCode: 'CameraName(cameraNum)'.
	nameStr = nil ifTrue: [
		interpreterProxy success: false.
		^ 0].

	count := self cCode: '(int) strlen(nameStr)'.
	resultOop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: count.
	dst := self cCoerce: (interpreterProxy firstIndexableField: resultOop) to: 'char *'.
	0 to: count - 1 do: [:i | dst at: i put: (nameStr at: i)].

	interpreterProxy pop: 2 thenPush: resultOop.  "pop arg and rcvr, push result"
	^ 0
