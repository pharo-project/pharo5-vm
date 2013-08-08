primitives - signal forwarding
primitiveSigUsr1Number
	"Integer value corresponding to SIGUSR1"

	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self sigUsr1Number
