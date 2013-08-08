internal interpreter access
pushInteger: integerValue
	self push: (self integerObjectOf: integerValue).