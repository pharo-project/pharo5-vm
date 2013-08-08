memory space primitives
primitiveIsYoung
	"Primitive. Answer whether the argument to the primitive resides in young space."
	| oop |
	<export: true>
	oop := self stackObjectValue: 0.
	self successful ifTrue:[
		self pop: argumentCount + 1.
		self pushBool: oop >= youngStart.
	].