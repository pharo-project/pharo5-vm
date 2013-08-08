primitives - signal forwarding
primitiveSigQuitNumber
	"Integer value corresponding to SIGQUIT"

	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self sigQuitNumber
