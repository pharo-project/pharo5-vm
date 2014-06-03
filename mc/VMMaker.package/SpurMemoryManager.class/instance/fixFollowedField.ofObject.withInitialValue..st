forwarding
fixFollowedField: fieldIndex ofObject: anObject withInitialValue: initialValue
	"Private helper for followField:ofObject: to avoid code duplication for rare case."
	<inline: false>
	| objOop |
	self assert: (self isOopForwarded: initialValue).
	objOop := self followForwarded: initialValue.
	self storePointer: fieldIndex ofObject: anObject withValue: objOop.
	^objOop