as yet unclassified
isConcreteRISCTempRegister: concreteRegister
	"For tests to filter-out bogus values left in the ConcreteRISCTempRegister, if any."
	^concreteRegister = AT
		or: [concreteRegister = Cmp
		or: [concreteRegister = Overflow
		or: [concreteRegister = BranchTemp]]]