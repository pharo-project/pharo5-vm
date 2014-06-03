data
testSinData
	self verifyTestData: 'sin-small.dat' using:[:f| self sin: f].
	self verifyTestData: 'sin-large.dat' using:[:f| self sin: f].
