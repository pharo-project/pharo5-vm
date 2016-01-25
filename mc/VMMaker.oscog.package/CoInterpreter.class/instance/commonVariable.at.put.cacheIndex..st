indexing primitive support
commonVariable: rcvr at: index put: value cacheIndex: atIx
	"There is no atCache in the CoInterpreter."
	self shouldNotImplement