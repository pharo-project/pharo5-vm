primitives
primitiveSetDefaultSoundPlayer
	"Tell the operating system to use the specified device name as the output device for sound."
	"arg at top of stack is the String"
	| deviceName obj srcPtr sz |
	<export: true>
	<var: 'deviceName' declareC: 'char deviceName[257]'>
	<var: 'srcPtr' type: #'char *'>

	"Parse arguments"
	interpreterProxy methodArgumentCount = 1 ifFalse:
		[^interpreterProxy primitiveFail].
	obj := interpreterProxy stackValue: 0.
	(interpreterProxy isBytes: obj) ifFalse:
		[^interpreterProxy primitiveFail].
	(sz := interpreterProxy byteSizeOf: obj) <= 256 ifFalse:
		[^interpreterProxy primitiveFail].
	srcPtr := interpreterProxy firstIndexableField: obj.
	self touch: srcPtr.
	self touch: deviceName.
	self touch: sz.
	self cCode: 'strncpy(deviceName, srcPtr, sz)'.
	self cCode: 'deviceName[sz] = NULL'.
	
	"do the work"
	self cCode: 'setDefaultSoundPlayer(deviceName)'.
	interpreterProxy failed ifFalse: "pop arg, leave receiver"
		[interpreterProxy pop: 1]