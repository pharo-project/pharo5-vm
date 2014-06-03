memory space primitives
primitiveIsYoung
	"Primitive. Answer whether the argument to the primitive resides in young space."
	| oop |
	<export: true>
	<option: #SqueakV3ObjectMemory> "for now..."
	oop := self stackObjectValue: 0.
	self successful ifTrue:
		[self pop: argumentCount + 1 thenPushBool: (self oop: oop isGreaterThanOrEqualTo: objectMemory youngStart)]