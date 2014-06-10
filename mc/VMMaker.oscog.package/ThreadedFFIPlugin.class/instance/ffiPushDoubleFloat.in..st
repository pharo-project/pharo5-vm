marshalling
ffiPushDoubleFloat: value in: calloutState
	<var: #calloutState type: #double>
	<var: #calloutState type: #'CalloutState *'>
	^self subclassResponsibility