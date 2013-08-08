primitives - signal forwarding
primitiveSigIntNumber
	"Integer value corresponding to SIGINT"

	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self sigIntNumber
