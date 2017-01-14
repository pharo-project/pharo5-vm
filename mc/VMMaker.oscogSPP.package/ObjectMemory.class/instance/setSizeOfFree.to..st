header access
setSizeOfFree: chunk to: byteSize
	"Set the header of the given chunk to make it be a free chunk of the given size."

	self longAt: chunk put: ((byteSize bitAnd: AllButTypeMask) bitOr: HeaderTypeFree).