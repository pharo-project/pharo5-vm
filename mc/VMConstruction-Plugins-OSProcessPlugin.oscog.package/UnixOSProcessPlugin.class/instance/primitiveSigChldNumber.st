primitives - signal forwarding
primitiveSigChldNumber
	"Integer value corresponding to SIGCHLD"

	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self sigChldNumber
