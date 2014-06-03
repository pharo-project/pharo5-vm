obj stacks
printObjStack: objStack
	<api>
	objStack = nilObj
		ifTrue:
			[coInterpreter print: 'nil'; cr]
		ifFalse:
			[self printObjStackPage: objStack
				myIndex: (self fetchPointer: ObjStackMyx ofObject: objStack)
				pageType: ObjStackMyx]