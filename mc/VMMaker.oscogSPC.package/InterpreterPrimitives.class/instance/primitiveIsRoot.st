memory space primitives
primitiveIsRoot
	"Primitive. Answer whether the argument to the primitive is a root for young space"
	| oop |
	<export: true>
	<option: #SqueakV3ObjectMemory>
	oop := self stackObjectValue: 0.
	self successful ifTrue:
		[self
			pop: argumentCount + 1
			thenPushBool: (objectMemory isYoungRoot: oop)]