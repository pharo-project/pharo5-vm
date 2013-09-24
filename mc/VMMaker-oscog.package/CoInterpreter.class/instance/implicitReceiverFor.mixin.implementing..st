newspeak bytecode support
implicitReceiverFor: rcvr mixin: mixin implementing: selector
	"This is used to implement the innards of the pushImplicitReceiverBytecode,
	 used for implicit receiver sends in NS2/NS3.  Find the nearest lexically-enclosing
	 implementation of selector by searching up the static chain of anObject,
	 starting at mixin's application.  This is an iterative implementation derived from

	<ContextPart> implicitReceiverFor: obj <Object>
					withMixin: mixin <Mixin>
					implementing: selector <Symbol> ^<Object>"

	<api>
	<option: #NewspeakVM>
	cogit breakOnImplicitReceiver ifTrue:
		[self sendBreakpoint: selector receiver: nil].
	^super implicitReceiverFor: rcvr mixin: mixin implementing: selector