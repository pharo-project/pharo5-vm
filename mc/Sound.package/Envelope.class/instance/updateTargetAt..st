applying
updateTargetAt: mSecs
	"Send my updateSelector to the given target object with the value of this envelope at the given number of milliseconds from its onset. Answer true if the value changed."

	| newValue |
	newValue := self valueAtMSecs: mSecs.
	newValue = lastValue ifTrue: [^ false].
	target
		perform: updateSelector
		with: newValue.
	lastValue := newValue.
	^ true
