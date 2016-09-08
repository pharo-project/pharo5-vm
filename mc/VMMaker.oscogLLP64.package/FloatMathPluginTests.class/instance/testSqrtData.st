data
testSqrtData
	self verifyTestData: 'sqrt-small.dat' using:[:f| self sqrt: f abs].
	self verifyTestData: 'sqrt-large.dat' using:[:f| self sqrt: f abs].