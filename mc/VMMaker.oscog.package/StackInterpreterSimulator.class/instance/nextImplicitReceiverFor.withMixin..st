newspeak bytecode support
nextImplicitReceiverFor: anObject withMixin: mixin
	lookupCount := lookupCount + 1.
	^super nextImplicitReceiverFor: anObject withMixin: mixin