callout support
ffiArgByValue: oop
	"Support for generic callout. Prepare an argument by value for a callout."
	| atomicType intValue floatValue |
	<inline: true>
	<var: #floatValue type: 'double'>
	atomicType := self atomicTypeOf: ffiArgHeader.
	"check if the range is valid"
	(atomicType < 0 or:[atomicType > FFITypeDoubleFloat])
		ifTrue:[^self ffiFail: FFIErrorBadAtomicType].
	atomicType < FFITypeSingleFloat ifTrue:["integer types"
		(atomicType >> 1) = (FFITypeSignedLongLong >> 1)
			ifTrue:[intValue := oop] "ffi support code must coerce longlong"
			ifFalse:[intValue := self ffiIntegerValueOf: oop]. "does all the coercions"
		interpreterProxy failed ifTrue:[^self ffiFail: FFIErrorCoercionFailed].
		self dispatchOn: atomicType
			in: #(
				ffiPushVoid:
				ffiPushUnsignedInt:
				ffiPushUnsignedByte:
				ffiPushSignedByte:
				ffiPushUnsignedShort:
				ffiPushSignedShort:
				ffiPushUnsignedInt:
				ffiPushSignedInt:
				ffiPushUnsignedLongLongOop:
				ffiPushSignedLongLongOop:
				ffiPushUnsignedChar:
				ffiPushSignedChar:)
		with: intValue.
	] ifFalse:[
		"either float or double"
		floatValue := self ffiFloatValueOf: oop.
		interpreterProxy failed ifTrue:[^self ffiFail: FFIErrorCoercionFailed].
		atomicType = FFITypeSingleFloat
			ifTrue:[self ffiPushSingleFloat: floatValue]
			ifFalse:[self ffiPushDoubleFloat: floatValue].
	].
	^0