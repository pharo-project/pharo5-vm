object access primitives
pruneStack: stack stackp: stackp
	"Prune the stack to contain only the path, removing stacked indices
	 and mapping frame pointers to contexts  The  issue here is that a
	 GC can occur during ensureFrameIsMarried:SP:, but frame pointers
	 are not valid objects.  So first prune back to objects and framePointers
	 as integers, and then replace frame pointers as integers by contexts."
	
	<inline: false>
	| objOrFP theStack finger |
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #theFPAbove type: #'char *'>
	finger := 1.
	2 to: stackp - 1 by: 2 do:
		[:i|
		objOrFP := objectMemory fetchPointer: i ofObject: stack.
		(stackPages couldBeFramePointer: (self cCoerceSimple: objOrFP to: #'char *')) ifTrue:
			[objOrFP := self withSmallIntegerTags: objOrFP].
		objectMemory
			storePointerUnchecked: finger
			ofObject: stack
			withValue: objOrFP.
		finger := finger + 1].
	finger to: (objectMemory lengthOf: stack) - 1 do:
		[:i|
		objectMemory
			storePointerUnchecked: i
			ofObject: stack
			withValue: objectMemory nilObject].
	objectMemory pushRemappableOop: (theStack := stack).
	1 to: finger - 1 do:
		[:i| | thePage theFP theFPAbove |
		objOrFP := objectMemory fetchPointer: i ofObject: theStack.
		(self isIntegerObject: objOrFP) ifTrue:
			[theFP := self withoutSmallIntegerTags: objOrFP.
			 thePage := stackPages stackPageFor: theFP.
			 theFPAbove := self findFrameAbove: theFP inPage: thePage.
			 objOrFP := self ensureFrameIsMarried: theFP SP: (self frameCallerSP: theFPAbove).
			 theStack := objectMemory topRemappableOop.
			 objectMemory "after a GC stack may no longer be a root."
				storePointer: finger
				ofObject: theStack
				withValue: objOrFP]].
	objectMemory popRemappableOop