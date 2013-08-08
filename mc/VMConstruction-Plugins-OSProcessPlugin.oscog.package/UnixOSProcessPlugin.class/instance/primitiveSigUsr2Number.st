primitives - signal forwarding
primitiveSigUsr2Number
	"Integer value corresponding to SIGUSR2"

	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self sigUsr2Number
