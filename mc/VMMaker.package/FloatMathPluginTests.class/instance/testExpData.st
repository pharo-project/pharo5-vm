data
testExpData
	self verifyTestData: 'exp-small.dat' using:[:f| self exp: f].
	self verifyTestData: 'exp-large.dat' using:[:f| self exp: f].
