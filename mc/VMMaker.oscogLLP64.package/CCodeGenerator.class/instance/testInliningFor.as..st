utilities
testInliningFor: selector as: inlineFlagOrSymbol
	"Test inlining for the method with the given selector.
	 Do all inlining first (cuz that's how the algorithm works).
	 Then try and inline into a copy of the method.  This isn't
	 exactly what happens in the real deal but is close enough."
	| meth |
	((breakDestInlineSelectors includes:  selector)
	 or: [(breakSrcInlineSelectors includes:  selector)]) ifTrue:
		[self halt].
	meth := (self methodNamed: selector) copy.
	self doBasicInlining: inlineFlagOrSymbol.
	self halt.
	meth tryToInlineMethodsIn: self