accessing
varBaseAddress
	"We expect simulatedAddresses to have around 40 entries.  48 is hopefully a good maximum."
	<doNotGenerate>
	^self cCode: [coInterpreter varBaseAddress]
		inSmalltalk: [self fakeAddressFor: nil index: 48]