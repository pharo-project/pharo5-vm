stack access
pushInteger: integerValue
	<returnTypeC: #sqInt>
	self push: (self integerObjectOf: integerValue).