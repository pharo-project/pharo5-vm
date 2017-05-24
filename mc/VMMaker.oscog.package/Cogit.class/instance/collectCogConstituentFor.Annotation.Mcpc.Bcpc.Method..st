profiling primitives
collectCogConstituentFor: descriptor Annotation: isBackwardBranchAndAnnotation Mcpc: mcpc Bcpc: bcpc Method: cogMethodArg
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #mcpc type: #'char *'>
	<var: #cogMethodArg type: #'void *'>
	| address |
	descriptor ifNil: [^0].
	descriptor isMapped ifFalse: [^0].
	address := self positiveMachineIntegerFor: mcpc.
	address ifNil: [^InsufficientCodeSpace]. "We should have a dedicated error code... This cannot trigger a GC but fails if not enough space in Eden,"
	"Assumes we write the values into topRemappableOop"
	coInterpreter
		storePointerUnchecked: cogConstituentIndex
		ofObject: coInterpreter topRemappableOop
		withValue: address.
	coInterpreter
		storePointerUnchecked: cogConstituentIndex + 1
		ofObject: coInterpreter topRemappableOop
		withValue: (objectMemory integerObjectOf: bcpc)..
	cogConstituentIndex := cogConstituentIndex + 2.
	^ 0