object access primitives
primitiveTestShortenIndexableSize
	"Given an object with indexable pointer fields, reduce the size of the indexable fields
	to the requested size. Answer the number of bytes freed, or zero if the object cannot
	be shortened."
	<option: #TestingPrimitives>
	<export: true>
	| array newSize bytesFreed |
	newSize := self stackIntegerValue: 0.
	array := self stackValue: 1.
	self pop: argumentCount + 1.
	bytesFreed := self shorten: array toIndexableSize: newSize.
	self pushInteger: bytesFreed