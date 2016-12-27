inlining support
methodIsEffectivelyComplete: selector in: aCodeGen
	"Answer if selector is effectively not inlineable in the receiver.
	 This is tricky because block inlining requires that certain methods must be inlined, which
	 can be at odds wuth the opportunistic strategy the inliner takes.  Since the inliner only
	 inlines complete methods and certain methods may never be marked as complete (e.g.
	 recursive methods) we have to short-cut certain kinds of send.  In particular, short-cut
	 sends that turn into jumps in the interpret routine (sharedCase and sharedLabel below)."
	^(aCodeGen methodNamed: selector)
		ifNil: [true] "builtins or externals are not inlineable"
		ifNotNil:
			[:m|
			 m isComplete
			 "unlinable methods can't be inlined"
			 or: [m mayBeInlined not
			 "Methods which are inlined as jumps don't need inlining"
			 or: [m sharedCase notNil or: [m sharedLabel notNil]]]]