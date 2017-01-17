transformations
copyWithoutReturn
	self assert: self endsWithReturn.
	^self class new
		setSelector: selector
			receiver: receiver
				arguments: (arguments collect:
								[:arg|
								 arg endsWithReturn
									ifTrue: [arg copyWithoutReturn]
									ifFalse: [arg]]);
		yourself