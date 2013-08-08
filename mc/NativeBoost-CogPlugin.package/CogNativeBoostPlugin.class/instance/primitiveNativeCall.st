invoking native code
primitiveNativeCall
	| len trailer codeOffset fnPtr  result platformId argCount nativeMethod |
	<export: true>
	<var: #fnPtr declareC: 'sqInt (*fnPtr)(void)'>

	enabled ifFalse: [ ^ self primitiveFailFor: (lastError := ErrNotEnabled) ].
	nativeMethod := interpreterProxy primitiveMethod.
	len := interpreterProxy slotSizeOf: nativeMethod.
	trailer := (self byteAt: nativeMethod + BaseHeaderSize + len-1 ).
	(trailer bitAnd: 2r11111100) = NativeCodeTrailerId " Native code trailer"
		ifFalse: [ ^ self primitiveFailFor: (lastError := ErrNoNativeCodeInMethod) ].
	
	"the next two bytes is a platform ID for the native code"
	platformId := (self byteAt: nativeMethod + BaseHeaderSize + len-2 ) + ((self byteAt: nativeMethod + BaseHeaderSize + len-3 ) << 8).
	platformId = PlatformId ifFalse: [ ^ self primitiveFailFor: (lastError := ErrInvalidPlatformId) ].
	
	"the next two bytes should be an offset for a native code start"
	codeOffset := (self byteAt: nativeMethod + BaseHeaderSize + len-4 ) + ((self byteAt: nativeMethod + BaseHeaderSize + len-5 ) << 8).
	
	argCount := interpreterProxy methodArgumentCount.

	"entry point address is method oop + header + len - codeOffset"
	fnPtr := self cCoerce: (self cCoerce: (interpreterProxy firstFixedField: nativeMethod) to: 'char*' ) + len - codeOffset to: 'sqInt (*)(void)'.
	
	result := self fnPtr.
	self failed ifFalse: [
		interpreterProxy pop: argCount + 1 thenPush: result.
		] ifTrue: [ lastError := interpreterProxy primitiveFailureCode].
