callout support
ffiArgByValue: oop in: calloutState
	"Support for generic callout. Prepare an argument by value for a callout."
	<var: #calloutState type: #'CalloutState *'>
	| atomicType intValue floatValue |
	<inline: true>
	<var: #floatValue type: #double>
	atomicType := self atomicTypeOf: calloutState ffiArgHeader.
	"check if the range is valid"
	(atomicType < 0 or:[atomicType > FFITypeDoubleFloat])
		ifTrue:[^FFIErrorBadAtomicType].
	atomicType < FFITypeSingleFloat ifTrue:["integer types"
		(atomicType >> 1) = (FFITypeSignedLongLong >> 1)
			ifTrue:[intValue := oop] "ffi support code must coerce longlong"
			ifFalse:[intValue := self ffiIntegerValueOf: oop]. "does all the coercions"
		interpreterProxy failed ifTrue:[^FFIErrorCoercionFailed].
		^self dispatchOn: atomicType
			in: #(
				ffiPushVoid:in:
				ffiPushUnsignedInt:in:
				ffiPushUnsignedByte:in:
				ffiPushSignedByte:in:
				ffiPushUnsignedShort:in:
				ffiPushSignedShort:in:
				ffiPushUnsignedInt:in:
				ffiPushSignedInt:in:
				ffiPushUnsignedLongLongOop:in:
				ffiPushSignedLongLongOop:in:
				ffiPushUnsignedChar:in:
				ffiPushSignedChar:in:)
			with: intValue
			with: calloutState].
	"either float or double"
	floatValue := self ffiFloatValueOf: oop.
	interpreterProxy failed ifTrue:
		[^FFIErrorCoercionFailed].
	atomicType = FFITypeSingleFloat
		ifTrue: [^self ffiPushSingleFloat: floatValue in: calloutState]
		ifFalse:[^self ffiPushDoubleFloat: floatValue in: calloutState]