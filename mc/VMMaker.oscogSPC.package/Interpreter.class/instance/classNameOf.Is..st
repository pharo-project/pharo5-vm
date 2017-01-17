plugin primitive support
classNameOf: aClass Is: className 
	"Check if aClass's name is className"
	| srcName name length |
	<var: #className type: 'char *'>
	<var: #srcName type: 'char *'>
	(self lengthOf: aClass) <= 6 ifTrue: [^ false].

	"Not a class but might be behavior"
	name := self fetchPointer: 6 ofObject: aClass.
	(self isBytes: name) ifFalse: [^ false].
	length := self stSizeOf: name.
	srcName := self cCoerce: (self arrayValueOf: name) to: 'char *'.
	0 to: length - 1 do: [:i | (srcName at: i) = (className at: i) ifFalse: [^ false]].
	"Check if className really ends at this point"
	^ (className at: length) = 0