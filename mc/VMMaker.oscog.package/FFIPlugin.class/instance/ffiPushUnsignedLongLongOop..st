callout support
ffiPushUnsignedLongLongOop: oop
	"Push a longlong type (e.g., a 64bit integer).
	Note: Coercions from float are *not* supported."
	| lowWord highWord length ptr |
	<var: #ptr type:'unsigned char *'>
	oop == interpreterProxy nilObject 
		ifTrue:[^self ffiPushUnsignedLong: 0 Long: 0.]. "@@: check this"
	oop == interpreterProxy falseObject 
		ifTrue:[^self ffiPushUnsignedLong: 0 Long: 0].
	oop == interpreterProxy trueObject 
		ifTrue:[^self ffiPushUnsignedLong: 0 Long: 1].
	(interpreterProxy isIntegerObject: oop) ifTrue:[
		lowWord := interpreterProxy integerValueOf: oop.
		lowWord < 0 ifTrue:[^self ffiFail: FFIErrorCoercionFailed].
		highWord := 0.
	] ifFalse:[
		(interpreterProxy isLargePositiveIntegerObject: oop)
			ifFalse:[^interpreterProxy primitiveFail].
		(interpreterProxy isBytes: oop) ifFalse:[^self ffiFail: FFIErrorCoercionFailed].
		length := interpreterProxy byteSizeOf: oop.
		length > 8 ifTrue:[^self ffiFail: FFIErrorCoercionFailed].
		lowWord := highWord := 0.
		ptr := interpreterProxy firstIndexableField: oop.
		0 to: (length min: 4)-1 do:[:i|
			lowWord := lowWord + ((ptr at: i) << (i*8))].
		0 to: (length-5) do:[:i|
			highWord := highWord + ((ptr at: i+4) << (i*8))].
	].
	^self ffiPushUnsignedLong: lowWord Long: highWord.