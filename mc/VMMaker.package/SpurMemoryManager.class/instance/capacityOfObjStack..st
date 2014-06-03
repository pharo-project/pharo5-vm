obj stacks
capacityOfObjStack: objStack
	| total freeObj |
	objStack = nilObj ifTrue: [^0].
	total := ObjStackLimit negated.
	freeObj := objStack.
	[freeObj ~= 0] whileTrue:
		[total := total + ObjStackLimit.
		 freeObj := self fetchPointer: ObjStackFreex ofObject: freeObj].
	freeObj := objStack.
	[freeObj ~= 0] whileTrue:
		[total := total + ObjStackLimit.
		 freeObj := self fetchPointer: ObjStackNextx ofObject: freeObj].
	^total