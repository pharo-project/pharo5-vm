private
stringLength
	^precision isNil
		ifTrue: [SmallInteger maxVal]
		ifFalse: [precision]