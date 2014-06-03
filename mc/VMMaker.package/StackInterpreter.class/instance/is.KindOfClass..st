plugin primitive support
is: oop KindOfClass: aClass
	"Support for external primitives."
	<api>
	| oopClass |
	oopClass := objectMemory fetchClassOf: oop.
	[oopClass = objectMemory nilObject] whileFalse:
		[oopClass = aClass ifTrue: [^true].
		 oopClass := self superclassOf: oopClass].
	^false