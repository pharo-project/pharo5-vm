primitives - child process management
primitiveOneShot
	"Anwer true the first time this primitive is called in a Squeak session, and false thereafter."

	| thisPrimHasBeenCalled |
	<export: true>
	<var: 'thisPrimHasBeenCalled' declareC: 'static int thisPrimHasBeenCalled= 0'>
	(thisPrimHasBeenCalled = 0)
		ifTrue:
			[thisPrimHasBeenCalled := 1.
			interpreterProxy pop: 1 thenPush: interpreterProxy trueObject]
		ifFalse:
			[interpreterProxy pop: 1 thenPush: interpreterProxy falseObject]
