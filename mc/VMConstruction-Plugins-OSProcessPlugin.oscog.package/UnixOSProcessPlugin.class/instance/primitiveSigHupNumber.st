primitives - signal forwarding
primitiveSigHupNumber
	"Integer value corresponding to SIGHUP"

	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: self sigHupNumber
