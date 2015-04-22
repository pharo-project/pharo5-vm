testing
addressIsInCodeZone: address
	"N.B. We /don't/ write this as address between: codeBase and: methodZone limitZony in case we're
	 testing an address in a method whose code has yet to be allocated and is hence >= methodZone limitZony"
	^address asUnsignedInteger >= codeBase
	  and: [address < (methodZone youngReferrers ifNil: [0])]