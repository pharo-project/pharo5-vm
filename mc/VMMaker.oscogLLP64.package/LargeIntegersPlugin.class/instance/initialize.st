ST initialize
initialize
	"Initializes ST constants; C's are set by class>>declareCVarsIn:."
	<returnTypeC: 'void'>
	self cCode: '"nothing to do here"'
		inSmalltalk: 
			[andOpIndex := 0.
			orOpIndex := 1.
			xorOpIndex := 2]