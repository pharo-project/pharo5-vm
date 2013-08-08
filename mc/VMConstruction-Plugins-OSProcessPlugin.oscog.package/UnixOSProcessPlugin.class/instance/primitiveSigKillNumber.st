primitives - signal forwarding
primitiveSigKillNumber
	"Integer value corresponding to SIGKILL"

	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self sigKillNumber
