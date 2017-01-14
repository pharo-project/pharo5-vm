plugin support
classNameOf: aClass Is: className
	"Check if aClass' name is className"
	| name |
	(objectMemory lengthOf: aClass) <= classNameIndex ifTrue:
		[^false]. "Not a class but maybe behavior" 
	name := objectMemory fetchPointer: classNameIndex ofObject: aClass.
	(objectMemory isBytes: name) ifFalse:
		[^false].
	^ className = (self stringOf: name)