utilities
fetchArray: fieldIndex ofObject: objectPointer
	"Fetch the instance variable at the given index of the given object. Return the address of first indexable field of resulting array object, or fail if the instance variable does not contain an indexable bytes or words object."
	"Note: May be called by translated primitive code."

	| arrayOop |
	<returnTypeC: 'void *'>
	arrayOop := objectMemory fetchPointer: fieldIndex ofObject: objectPointer.
	^ self arrayValueOf: arrayOop
