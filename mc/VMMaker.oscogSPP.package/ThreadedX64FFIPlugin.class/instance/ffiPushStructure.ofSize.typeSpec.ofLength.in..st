marshalling
ffiPushStructure: pointer ofSize: structSize typeSpec: argSpec ofLength: argSpecSize in: calloutState
	<var: #pointer type: #'void *'>
	<var: #argSpec type: #'sqInt *'>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	self subclassResponsibility