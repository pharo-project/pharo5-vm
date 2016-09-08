marshalling
ffiPushStructure: pointer ofSize: structSize typeSpec: argSpec ofLength: argSpecSize in: calloutState
	<var: #pointer type: #'void *'>
	<var: #argSpec type: #'sqInt *'>
	<var: #calloutState type: #'CalloutState *'>
	<var: #arg type: #usqLong>
	<inline: true>
	structSize <= 0 ifTrue:
		[^FFIErrorStructSize].
	(structSize <= WordSize
	 and: [(structSize bitAnd: structSize - 1) = 0 "a.k.a. structSize isPowerOfTwo"]) ifTrue:
		[| arg |
		self mem: (self addressOf: arg) cp: pointer y: structSize.
		^self ffiPushUnsignedLongLong: arg in: calloutState].

	"For now just push the pointer; we should copy the struct to the outgoing stack frame!!"
	self flag: 'quick hack'.
	^self ffiPushPointer: pointer in: calloutState