marshalling
ffiPushSignedLongLong: value in: calloutState
	<var: #value type: #sqLong>
	<var: #calloutState type: #'CalloutState *'>
	^self subclassResponsibility