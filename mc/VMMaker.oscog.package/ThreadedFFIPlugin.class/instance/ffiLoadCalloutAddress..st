symbol loading
ffiLoadCalloutAddress: lit
	"Load the address of the foreign function from the given object"
	| addressPtr address ptr |
	<var: #ptr type: #'sqIntptr_t *'>
	"Lookup the address"
	addressPtr := interpreterProxy fetchPointer: 0 ofObject: lit.
	"Make sure it's an external handle"
	address := self ffiContentsOfHandle: addressPtr errCode: FFIErrorBadAddress.
	interpreterProxy failed ifTrue:
		[^0].
	address = 0 ifTrue:"Go look it up in the module"
		[self externalFunctionHasStackSizeSlot ifTrue:
			[interpreterProxy
				storePointer: ExternalFunctionStackSizeIndex
				ofObject: lit
				withValue: (interpreterProxy integerObjectOf: -1)].
		(interpreterProxy slotSizeOf: lit) < 5 ifTrue:
			[^self ffiFail: FFIErrorNoModule].
		address := self ffiLoadCalloutAddressFrom: lit.
		interpreterProxy failed ifTrue:
			[^0].
		"Store back the address"
		ptr := interpreterProxy firstIndexableField: addressPtr.
		ptr at: 0 put: address].
	^address