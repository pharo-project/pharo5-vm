callback support
reestablishContextPriorToCallback: callbackContext
	"callbackContext is an activation of invokeCallback:stack:registers:jmpbuf:.  Its sender
	 is the interpreter's state prior to the callback.  Reestablish that state."
	| calloutContext |
	<export: true>
	(self fetchClassOf: callbackContext) ~~ (self splObj: ClassMethodContext) ifTrue:
		[^false].
	calloutContext := self fetchPointer: SenderIndex ofObject: callbackContext.
	self newActiveContext: calloutContext.
	^true