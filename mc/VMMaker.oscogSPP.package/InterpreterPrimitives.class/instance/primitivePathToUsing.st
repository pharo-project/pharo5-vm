other primitives
primitivePathToUsing
	"primitivePathTo: anObject using: stack <Array> followWeak: boolean
	 Answer a path to anObject from the root that does not pass through
	 the current context"
	| err path |
	<export: true>
	self externalWriteBackHeadFramePointers.
	argumentCount >= 2 ifFalse:
		[^self primitiveFailFor: PrimErrBadNumArgs].
	(self stackTop = objectMemory trueObject
	 or: [self stackTop = objectMemory falseObject]) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	err := self pathTo: (self stackValue: 2)
				using: (self stackValue: 1)
				followWeak: self stackTop = objectMemory trueObject.
	err ~= 0 ifTrue:
		[^self primitiveFailFor: err].
	path := self self stackValue: 1.
	self pop: argumentCount + 1 thenPush: path