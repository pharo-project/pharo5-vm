running
makeSmallTestData
	"self basicNew makeSmallTestData"
	self makeTestData: 'sin-small.dat' using:[:f| self sin: f] seed: 321567 rounds: 10000.
	self makeTestData: 'log-small.dat' using:[:f| self ln: f abs] seed: 321567 rounds: 10000.
	self makeTestData: 'sqrt-small.dat' using:[:f| self sqrt: f abs] seed: 321567 rounds: 10000.
	self makeTestData: 'atan-small.dat' using:[:f| self arcTan: f] seed: 321567 rounds: 10000.
	self makeTestData: 'exp-small.dat' using:[:f| self exp: f] seed: 321567 rounds: 10000.
