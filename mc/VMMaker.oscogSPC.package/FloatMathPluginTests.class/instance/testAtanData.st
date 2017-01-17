data
testAtanData
	self verifyTestData: 'atan-small.dat' using:[:f| self arcTan: f].
	self verifyTestData: 'atan-large.dat' using:[:f| self arcTan: f].
