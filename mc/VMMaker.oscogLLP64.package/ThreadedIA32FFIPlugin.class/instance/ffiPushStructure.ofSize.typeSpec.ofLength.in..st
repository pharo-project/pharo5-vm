marshalling
ffiPushStructure: pointer ofSize: structSize typeSpec: argSpec ofLength: argSpecSize in: calloutState
	<var: #pointer type: #'void *'>
	<var: #argSpec type: #'sqInt *'>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	| roundedSize |
	roundedSize := structSize + 3 bitClear: 3.
	calloutState currentArg + roundedSize > calloutState limit ifTrue:
		[^FFIErrorCallFrameTooBig].
	self mem: calloutState currentArg cp: pointer y: structSize.
	calloutState currentArg: calloutState currentArg + roundedSize.
	^0