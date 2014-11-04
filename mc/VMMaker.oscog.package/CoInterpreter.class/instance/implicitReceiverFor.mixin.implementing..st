newspeak bytecode support
implicitReceiverFor: methodReceiver mixin: methodMixin implementing: selector
	"This is used to implement implicit receiver sends in Newspeak. Find the nearest
	 lexically-enclosing implementation of selector by searching up the static chain of the
	 method's receiver, starting at mixin's application. This implementation is derived from

	<ContextPart> implicitReceiverFor: methodReceiver <Object>
					in: methodMixin <Mixin>
					implementing: selector <Symbol> ^<Object>"

	<api>
	<option: #NewspeakVM>
	cogit breakOnImplicitReceiver ifTrue:
		[self sendBreakpoint: selector receiver: nil].
	^super implicitReceiverFor: methodReceiver mixin: methodMixin implementing: selector