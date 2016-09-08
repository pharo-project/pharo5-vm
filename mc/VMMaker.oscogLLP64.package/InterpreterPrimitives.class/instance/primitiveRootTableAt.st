memory space primitives
primitiveRootTableAt
	"Primitive. Answer the nth element of the root table.
	This primitive avoids the creation of an extra array;
	it is intended for enumerations of the form:
		index := 1.
		[root := Smalltalk rootTableAt: index.
		root == nil] whileFalse:[index := index + 1].
	"
	<export: true>
	<option: #SqueakV3ObjectMemory>
	| index |
	index := self stackIntegerValue: 0.
	self success: (index > 0 and:[index <= objectMemory rootTableCount]).
	self successful ifTrue:[
		self pop: argumentCount + 1.
		self push: (objectMemory rootTable at: index).
	]