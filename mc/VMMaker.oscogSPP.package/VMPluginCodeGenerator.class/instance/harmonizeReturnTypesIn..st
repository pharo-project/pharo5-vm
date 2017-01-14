type inference
harmonizeReturnTypesIn: aSetOfTypes
	"Eliminate signed/unsigned conflicts in aSetOfTypes.  Override to
	 default to void if any one return type is void."
	^(aSetOfTypes includes: #void)
		ifTrue: [Set with: #void]
		ifFalse: [super harmonizeReturnTypesIn: aSetOfTypes]