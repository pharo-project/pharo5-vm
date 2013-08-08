callout support
ffiPushUnsignedLongLongOop: oop in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	"Push an unsigned longlong type (e.g., a 64bit integer).
	Note: Coercions from float are *not* supported."
	| value |
	<var: #value type: #usqLong>
	(oop = interpreterProxy nilObject
	 or: [oop = interpreterProxy falseObject])
		ifTrue:[value := 0] ifFalse:
	[oop = interpreterProxy trueObject
		ifTrue:[value := 1] ifFalse:
	[value := interpreterProxy positive64BitValueOf: oop.
	 interpreterProxy failed ifTrue:
		[^FFIErrorCoercionFailed]]].
	^self ffiPushUnsignedLongLong: value in: calloutState