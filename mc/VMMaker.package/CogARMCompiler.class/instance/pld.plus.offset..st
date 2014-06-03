encoding
pld: baseReg plus: u offset: immediate
	"hint to memory that we will want to read from baseReg +/- imediate sometime soon"
	<inline: true>
	^ 2r11110101010100001111000000000000 bitOr: (baseReg<<16 bitOr:(u <<23 bitOr: immediate))