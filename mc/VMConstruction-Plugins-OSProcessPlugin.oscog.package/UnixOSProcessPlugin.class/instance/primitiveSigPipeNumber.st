primitives - signal forwarding
primitiveSigPipeNumber
	"Integer value corresponding to SIGPIPE"

	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self sigPipeNumber
