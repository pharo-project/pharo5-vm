plugin primitive support
is: oop KindOf: className
	"Support for external primitives."
	| oopClass |
	<var: #className type:#'char *'>
	oopClass := objectMemory fetchClassOf: oop.
	[oopClass = objectMemory nilObject] whileFalse:[
		(self classNameOf: oopClass Is: className) ifTrue:[^true].
		oopClass := self superclassOf: oopClass].
	^false