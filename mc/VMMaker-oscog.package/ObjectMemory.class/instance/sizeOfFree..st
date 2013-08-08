header access
sizeOfFree: oop
	"Return the size of the given chunk in bytes. Argument MUST be a free chunk."

	^ (self longAt: oop) bitAnd: AllButTypeMask