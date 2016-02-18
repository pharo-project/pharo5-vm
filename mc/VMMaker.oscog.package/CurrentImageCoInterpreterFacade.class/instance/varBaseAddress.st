accessing
varBaseAddress
	"This value is chosen for ARM, which has the ability to do 12-bit relative addresses from the var base register."
	^(variables at: 'stackLimit') - (1 << 11)