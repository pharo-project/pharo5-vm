plugin primitive support
classNameOf: aClass Is: className 
	"Check if aClass's name is className"
	| srcName name length |
	<var: #className type: #'char *'>
	<var: #srcName type: #'char *'>
	(objectMemory lengthOf: aClass) <= classNameIndex ifTrue:
		[^ false]. "Not a class but might be behavior"
	name := objectMemory fetchPointer: classNameIndex ofObject: aClass.
	(objectMemory isBytes: name) ifFalse:
		[^false].
	length := self stSizeOf: name.
	srcName := self cCoerce: (self arrayValueOf: name) to: 'char *'.
	0 to: length - 1 do: [:i | (srcName at: i) = (className at: i) ifFalse: [^false]].
	"Check if className really ends at this point"
	^(className at: length) = 0