utilities
fetchInteger: fieldIndex ofObject: objectPointer
	"Note: May be called by translated primitive code."

	| intOop |
	<inline: false>
	intOop := objectMemory fetchPointer: fieldIndex ofObject: objectPointer.
	^self checkedIntegerValueOf: intOop