callout support
ffiPushSignedLongLongOop: oop in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	"Push a longlong type (e.g., a 64bit integer).
	Note: Coercions from float are *not* supported."
	| value |
	<var: #value type: #sqLong>
	(oop = interpreterProxy nilObject
	 or: [oop = interpreterProxy falseObject])
		ifTrue:[value := 0] ifFalse:
	[oop = interpreterProxy trueObject
		ifTrue:[value := 1] ifFalse:
	[value := interpreterProxy signed64BitValueOf: oop.
	 interpreterProxy failed ifTrue:
		[^FFIErrorCoercionFailed]]].
	^self ffiPushSignedLongLong: value in: calloutState