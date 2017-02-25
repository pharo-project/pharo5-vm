plugin primitive support
is: oop KindOf: className
	"Support for external primitives."
	| oopClass |
	<var: #className type:'char *'>
	oopClass := self fetchClassOf: oop.
	[oopClass == nilObj] whileFalse:[
		(self classNameOf: oopClass Is: className) ifTrue:[^true].
		oopClass := self superclassOf: oopClass].
	^false