utilities
quickFetchInteger: fieldIndex ofObject: objectPointer
	"Return the integer value of the field without verifying that it is an integer value! For use in time-critical places where the integer-ness of the field can be guaranteed."

	| oop |
	oop := objectMemory fetchPointer: fieldIndex ofObject: objectPointer.
	self assert: (objectMemory isIntegerObject: oop).
	^objectMemory integerValueOf: oop