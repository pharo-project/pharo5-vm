primitives - signal forwarding
primitiveSigTermNumber
	"Integer value corresponding to SIGTERM"

	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self sigTermNumber
