plugin primitive support
is: oop MemberOf: className
	"Support for external primitives"
	| oopClass |
	<var: #className type:'char *'>
	oopClass := self fetchClassOf: oop.
	^(self classNameOf: oopClass Is: className)