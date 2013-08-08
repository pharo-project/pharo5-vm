callout support
ffiCreateIntegralResultOop: retVal ofAtomicType: atomicType in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	<var: #retVal type: #usqLong>
	"Callout support. Return the appropriate oop for the given atomic type"
	| shift value mask byteSize |
	self assert: atomicType < FFITypeSingleFloat.

	atomicType = FFITypeBool ifTrue:[
			"Make sure bool honors the byte size requested"
			byteSize := calloutState ffiRetHeader bitAnd: FFIStructSizeMask.
			value := byteSize = 4
						ifTrue:[retVal]
						ifFalse:[retVal bitAnd: 1 << (byteSize * 8) - 1].
			^value = 0
				ifTrue:[interpreterProxy falseObject]
				ifFalse:[interpreterProxy trueObject]].
	atomicType <= FFITypeSignedInt ifTrue:[
		"these are all generall integer returns"
		atomicType <= FFITypeSignedShort ifTrue:[
			"byte/short. first extract partial word, then sign extend"
			shift := (atomicType >> 1) * 8. "# of significant bits"
			value := retVal bitAnd: (1 << shift - 1). 
			(atomicType anyMask: 1) ifTrue:[
				"make the guy signed"
				mask := 1 << (shift-1).
				value := (value bitAnd: mask-1) - (value bitAnd: mask)].
			^interpreterProxy integerObjectOf: value].
		"32bit integer return"
		^(atomicType anyMask: 1)
			ifTrue:[interpreterProxy signed32BitIntegerFor: retVal] "signed return"
			ifFalse:[interpreterProxy positive32BitIntegerFor: retVal]]. "unsigned return"

	"longlong, char"
	(atomicType >> 1) = (FFITypeSignedLongLong >> 1) 
		ifTrue:[^(atomicType anyMask: 1)
				ifTrue:[interpreterProxy signed64BitIntegerFor: retVal] "signed return"
				ifFalse:[interpreterProxy positive64BitIntegerFor: retVal]]
		ifFalse:[^interpreterProxy 
					fetchPointer: (retVal bitAnd: 255)
					ofObject: interpreterProxy characterTable]