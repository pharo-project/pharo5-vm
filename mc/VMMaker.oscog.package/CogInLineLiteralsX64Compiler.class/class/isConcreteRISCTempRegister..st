testing
isConcreteRISCTempRegister: concreteRegister
	"For tests to filter-out bogus values left in the ConcreteRISCTempRegister, if any."
	^concreteRegister = ConcreteRISCTempReg