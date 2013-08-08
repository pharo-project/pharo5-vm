primitives - signal forwarding
primitiveSemaIndexFor
	"Answer the registration index of the semaphore currently associated with the
	signal handler for sigNum."

	| sigNum index |
	<export: true>
	sigNum := interpreterProxy stackIntegerValue: 0.
	semaIndices = nil
		ifTrue: [index := 0 "interpreter simulation"]
		ifFalse: [index := semaIndices at: sigNum].
	interpreterProxy pop: 2; pushInteger: index
