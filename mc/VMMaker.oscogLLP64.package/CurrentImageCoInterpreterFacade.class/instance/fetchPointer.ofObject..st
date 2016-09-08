accessing
fetchPointer: index ofObject: anOop
	| obj |
	obj := (objectMap keyAtValue: anOop).
	^self oopForObject: (obj isCompiledMethod
							ifTrue: [obj objectAt: index + 1]
							ifFalse: [obj instVarAt: index + 1])