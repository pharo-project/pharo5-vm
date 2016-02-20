marshalling
ffiPushStructure: pointer ofSize: structSize typeSpec: argSpec ofLength: argSpecSize in: calloutState
	<var: #pointer type: #'void *'>
	<var: #argSpec type: #'sqInt *'>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	structSize <= 0 ifTrue:
		[^FFIErrorStructSize].
	(structSize <= 16
	 and: [(structSize bitAnd: structSize - 1) = 0 "a.k.a. structSize isPowerOfTwo"]) ifTrue:
		[^self ffiPushUnsignedLongLong: (self cCoerceSimple: pointer to: #usqLong) in: calloutState].

	"For now just push the pointer; we should copy the struct to the outgoing stack frame!!"
	self flag: 'quick hack'.
	^self ffiPushPointer: pointer in: calloutState