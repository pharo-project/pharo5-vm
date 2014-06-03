running
makeLargeTestData
	"self basicNew makeLargeTestData"
	self makeTestData: 'sin-large.dat' using:[:f| self sin: f] seed: 432567 rounds: 1000000.
	self makeTestData: 'log-large.dat' using:[:f| self ln: f abs] seed: 432567 rounds: 1000000.
	self makeTestData: 'sqrt-large.dat' using:[:f| self sqrt: f abs] seed: 432567 rounds: 1000000.
	self makeTestData: 'atan-large.dat' using:[:f| self arcTan: f] seed: 432567 rounds: 1000000.
	self makeTestData: 'exp-large.dat' using:[:f| self exp: f] seed: 432567 rounds: 1000000.
