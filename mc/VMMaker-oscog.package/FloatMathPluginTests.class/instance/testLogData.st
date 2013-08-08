data
testLogData
	self verifyTestData: 'log-small.dat' using:[:f| self ln: f abs].
	self verifyTestData: 'log-large.dat' using:[:f| self ln: f abs].
