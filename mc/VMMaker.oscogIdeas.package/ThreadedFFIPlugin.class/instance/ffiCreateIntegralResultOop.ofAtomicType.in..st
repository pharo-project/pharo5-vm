callout support
ffiCreateIntegralResultOop: retVal ofAtomicType: atomicType in: calloutState
	<inline: true>
	<var: #calloutState type: #'CalloutState *'>
	<var: #retVal type: #usqLong>
	"Callout support. Return the appropriate oop for the given atomic type"
	| shift value mask byteSize |
	<var: 'value' type: #usqLong>
	<var: 'mask' type: #usqLong>
	self assert: atomicType < FFITypeSingleFloat.

	atomicType = FFITypeBool ifTrue:
		["Make sure bool honors the byte size requested"
		 byteSize := calloutState ffiRetHeader bitAnd: FFIStructSizeMask.
		 value := byteSize = (self sizeof: retVal)
					ifTrue:[retVal]
					ifFalse:[retVal bitAnd: 1 asUnsignedLongLong << (byteSize * 8) - 1].
		 ^value = 0
			ifTrue:[interpreterProxy falseObject]
			ifFalse:[interpreterProxy trueObject]].
	atomicType <= FFITypeSignedInt ifTrue:
		["these are all generall integer returns"
		atomicType <= (BytesPerWord = 8 ifTrue: [FFITypeSignedInt] ifFalse: [FFITypeSignedShort]) ifTrue:
			["byte/short. first extract partial word, then sign extend"
			shift := (BytesPerWord = 8 and: [atomicType >= FFITypeUnsignedInt])
						ifTrue: [32]
						ifFalse: [(atomicType >> 1) * 8]. "# of significant bits"
			value := retVal bitAnd: (1 asUnsignedLongLong << shift - 1). 
			(atomicType anyMask: 1) ifTrue:
				["make the guy signed"
				mask := 1 asUnsignedLongLong << (shift-1).
				value := (value bitAnd: mask-1) - (value bitAnd: mask)].
			^interpreterProxy integerObjectOf: value].
		"Word sized integer return"
		^(atomicType anyMask: 1)
			ifTrue:[interpreterProxy signedMachineIntegerFor: retVal] "signed return"
			ifFalse:[interpreterProxy positiveMachineIntegerFor: retVal]]. "unsigned return"

	"longlong, char"
	^(atomicType >> 1) = (FFITypeSignedLongLong >> 1) 
		ifTrue:
			[(atomicType anyMask: 1)
				ifTrue:[interpreterProxy signed64BitIntegerFor: retVal] "signed return"
				ifFalse:[interpreterProxy positive64BitIntegerFor: retVal]]
		ifFalse:
			[interpreterProxy characterObjectOf: (retVal bitAnd: 16rFF)]