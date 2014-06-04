memory space primitives
primitiveRootTableAt
	"Primitive. Answer the nth element of the root table.
	This primitive avoids the creation of an extra array;
	it is intended for enumerations of the form:
		index := 1.
		[root := Smalltalk rootTableAt: index.
		root == nil] whileFalse:[index := index + 1].
	"
	| index |
	<export: true>
	index := self stackIntegerValue: 0.
	self success: (index > 0 and:[index <= rootTableCount]).
	successFlag ifTrue:[
		self pop: argumentCount + 1.
		self push: (rootTable at: index).
	].