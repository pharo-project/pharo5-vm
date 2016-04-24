object access primitives
pathTo: goal using: stack followWeak: followWeak
	"Trace objects and frames from the root, marking visited objects, pushing the current path on stack, until goal is found.
	 If found, unmark, leaving path in stack, and answer 0.  Otherwise answer an error:
		PrimErrBadArgument if stack is not an Array
		PrimErrBadIndex if search overflows stack
		PrimErrNotFound if goal cannot be found"
	| current index next stackSize stackp freeStartAtStart |
	<var: #index type: #sqInt> "Force the sign because typeInference does not seem to work"
	(objectMemory isArray: stack) ifFalse:
		[^PrimErrBadArgument].
	self assert: objectMemory allObjectsUnmarked.
	freeStartAtStart := objectMemory freeStart. "check no allocations during search"
	objectMemory beRootIfOld: stack. "so no store checks are necessary on stack"
	stackSize := objectMemory lengthOf: stack.
	objectMemory mark: stack.
	"no need. the current context is not reachable from the active process (suspendedContext is nil)"
	"objectMemory mark: self activeProcess."
	current := objectMemory specialObjectsOop.
	objectMemory mark: current.
	index := objectMemory lengthOf: current.
	stackp := 0.
	[[(index := index - 1) >= -1] whileTrue:
		[(stackPages couldBeFramePointer: current)
			ifTrue:
				[next := index >= 0
							ifTrue: [self field: index ofFrame: (self cCoerceSimple: current to: #'char *')]
							ifFalse: [objectMemory nilObject]]
			ifFalse:
				[index >= 0
					ifTrue:
						[next := (objectMemory isContextNonImm: current)
									ifTrue: [self fieldOrSenderFP: index ofContext: current]
									ifFalse: [objectMemory fetchPointer: index ofObject: current]]
					ifFalse:
						[next := objectMemory fetchClassOfNonImm: current]].
		 (stackPages couldBeFramePointer: next)
			ifTrue: [self assert: (self isFrame: (self cCoerceSimple: next to: #'char *')
										onPage: (stackPages stackPageFor: (self cCoerceSimple: next to: #'char *')))]
			ifFalse:
				[next >= heapBase ifTrue: "exclude Cog methods"
					[self assert: (self checkOkayOop: next)]].
		 next = goal ifTrue:
			[self assert: freeStartAtStart = objectMemory freeStart.
			 self unmarkAfterPathTo.
			 objectMemory storePointer: stackp ofObject: stack withValue: current.
			 self pruneStack: stack stackp: stackp.
			 ^0].
		 ((objectMemory isNonIntegerObject: next)
		  and: [(stackPages couldBeFramePointer: next)
				ifTrue: [(self frameIsMarked: next) not]
				ifFalse:
					[next >= heapBase "exclude Cog methods"
					  and: [(objectMemory isMarked: next) not
					  and: [((objectMemory isPointers: next) or: [objectMemory isCompiledMethod: next])
					  and: [followWeak or: [(objectMemory isWeakNonImm: next) not]]]]]])
			ifTrue:
				[stackp + 2 > stackSize ifTrue:
					[self assert: freeStartAtStart = objectMemory freeStart.
					 self unmarkAfterPathTo.
					 objectMemory nilFieldsOf: stack.
					 ^PrimErrBadIndex]. "PrimErrNoMemory ?"
				 objectMemory
					storePointerUnchecked: stackp ofObject: stack withValue: current;
					storePointerUnchecked: stackp + 1 ofObject: stack withValue: (objectMemory integerObjectOf: index).
				 stackp := stackp + 2.
				 (stackPages couldBeFramePointer: (self cCoerceSimple: next to: #'char *'))
					ifTrue:
						[self markFrame: next.
						index := self fieldsInFrame: (self cCoerceSimple: next to: #'char *')]
					ifFalse:
						[objectMemory mark: next.
						 (objectMemory isCompiledMethod: next)
							ifTrue: [index := (objectMemory literalCountOf: next) + LiteralStart]
							ifFalse: [index := objectMemory lengthOf: next]].
				 current := next]].
		 current = objectMemory specialObjectsOop ifTrue:
			[self assert: freeStartAtStart = objectMemory freeStart.
			 self unmarkAfterPathTo.
			 objectMemory nilFieldsOf: stack.
			^PrimErrNotFound].
		 index := objectMemory integerValueOf: (objectMemory fetchPointer: stackp - 1 ofObject: stack).
		 current := objectMemory fetchPointer: stackp - 2 ofObject: stack.
		 stackp := stackp - 2] repeat