callout support
ffiPushSignedLongLongOop: oop
	"Push a longlong type (e.g., a 64bit integer).
	Note: Coercions from float are *not* supported."
	| lowWord highWord length oopClass negative ptr |
	<var: #ptr type:'unsigned char *'>
	oop == interpreterProxy nilObject 
		ifTrue:[^self ffiPushSignedLong: 0 Long: 0.]. "@@: check this"
	oop == interpreterProxy falseObject
		ifTrue:[^self ffiPushSignedLong: 0 Long: 0].
	oop == interpreterProxy trueObject
		ifTrue:[^self ffiPushSignedLong: 0 Long: 1].
	(interpreterProxy isIntegerObject: oop) ifTrue:[
		lowWord := interpreterProxy integerValueOf: oop.
		lowWord < 0 
			ifTrue:[highWord := -1]
			ifFalse:[highWord := 0].
	] ifFalse:[
		oopClass := interpreterProxy fetchClassOf: oop.
		oopClass == interpreterProxy classLargePositiveInteger 
			ifTrue:[negative := false]
			ifFalse:[oopClass == interpreterProxy classLargeNegativeInteger 
				ifTrue:[negative := true]
				ifFalse:[^self ffiFail: FFIErrorCoercionFailed]].
		(interpreterProxy isBytes: oop) ifFalse:[^self ffiFail: FFIErrorCoercionFailed].
		length := interpreterProxy byteSizeOf: oop.
		length > 8 ifTrue:[^self ffiFail: FFIErrorCoercionFailed].
		lowWord := highWord := 0.
		ptr := interpreterProxy firstIndexableField: oop.
		0 to: (length min: 4)-1 do:[:i|
			lowWord := lowWord + ((ptr at: i) << (i*8))].
		0 to: (length-5) do:[:i|
			highWord := highWord + ((ptr at: i+4) << (i*8))].
		negative ifTrue:[
			lowWord := lowWord bitInvert32.
			highWord := highWord bitInvert32.
			lowWord = -1 "e.g., will overflow when adding one"
				ifTrue:[highWord := highWord + 1].
			lowWord := lowWord + 1].
	].
	^self ffiPushSignedLong: lowWord Long: highWord.