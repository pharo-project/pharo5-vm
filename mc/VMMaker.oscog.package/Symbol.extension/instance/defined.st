*VMMaker-interpreter simulator
defined
	"To allow constructs such as self cppIf: #'SA_NOCLDSTOP' defined ifTrue: [...].
	We could go look for a definition but likely there won't be one."
	^(thisContext sender methodClass bindingOf: self)
		ifNil: [false]
		ifNotNil: [:binding| binding value ~~ #undefined]