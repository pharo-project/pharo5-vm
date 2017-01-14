instruction decoding
pushClosureTemps: numTemps
	"230		11100110	iiiiiiii		PushNClosureTemps iiiiiiii"
	stackp := stackp + numTemps