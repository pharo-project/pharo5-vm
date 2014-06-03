obj stacks
push: objOop onObjStack: objStack
	self assert: (self addressCouldBeOop: objOop).
	(self isImmediate: objOop)
		ifTrue:
			[self assert: objStack = markStack.
			 self assert: (self addressCouldBeObj: (self topOfObjStack:
							(0 = (self fetchPointer: ObjStackTopx ofObject: objStack)
								ifTrue: [self fetchPointer: ObjStackNextx ofObject: objStack]
								ifFalse: [objStack])))]
		ifFalse: "There should be no weaklings on the mark stack."
			[self assert: (objStack = markStack and: [self isWeakNonImm: objOop]) not.
			"There should only be weaklings on the weaklingStack"
			 self assert: (objStack ~= weaklingStack or: [self isWeakNonImm: objOop])].
	^self noCheckPush: objOop onObjStack: objStack