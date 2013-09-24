accessing
classTableRootObj: anOop
	"For mapInterpreterOops"
	classTableRootObj := anOop.
	classTableFirstPage := self fetchPointer: 0 ofObject: classTableRootObj