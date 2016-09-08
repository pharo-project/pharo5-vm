forwarding
fixFollowedField: fieldIndex ofObject: anObject withInitialValue: initialValue
	"Private helper for followField:ofObject: to avoid code duplication for rare case."
	<inline: #never>
	| objOop |
	self assert: (self isOopForwarded: initialValue).
	"inlined followForwarded: for speed (one less test)"
	objOop := initialValue.
	[objOop := self fetchPointer: 0 ofMaybeForwardedObject: objOop.
	 self isOopForwarded: objOop] whileTrue.
	self storePointer: fieldIndex ofObject: anObject withValue: objOop.
	^objOop