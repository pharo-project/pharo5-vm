initialization
fakeAddressFor: anObject index: index
	"Answer a fake address for some variable based on some index.
	 The index will usually be the size of simulatedAddresses, but
	 in determining the varBaseAddress we take a guess at the final
	 size of simulatedAddresses."
	<doNotGenerate>
	^(index + 101 * objectMemory wordSize) negated
		bitAnd: ((backEnd notNil
				and: [backEnd wantsNearAddressFor: anObject])
					ifTrue: [self addressSpaceMask]
					ifFalse: [self allButTopBitOfAddressSpaceMask])