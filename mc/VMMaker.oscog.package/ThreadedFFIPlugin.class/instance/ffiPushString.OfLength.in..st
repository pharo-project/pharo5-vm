marshalling
ffiPushString: pointer OfLength: length in: calloutState
	<var: #pointer type: #'char *'>
	<var: #calloutState type: #'CalloutState *'>
	| copy |
	<var: #copy type: #'char *'>
	<inline: true>
	calloutState stringArgIndex >= MaxNumArgs ifTrue:
		[^PrimErrBadNumArgs negated].
	copy := self malloc: length + 1.
	copy isNil ifTrue:
		[^PrimErrNoCMemory negated].
	self mem: copy cp: pointer y: length.
	copy at: length put: 0.
	calloutState stringArgs at: calloutState stringArgIndex put: copy.
	calloutState stringArgIndex: calloutState stringArgIndex + 1.
	^self ffiPushPointer: copy in: calloutState