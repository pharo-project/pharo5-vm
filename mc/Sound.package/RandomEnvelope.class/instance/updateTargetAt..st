applying
updateTargetAt: mSecs
	"Send my updateSelector to the given target object with the value of this envelope at the given number of milliseconds from its onset. Answer true if the value changed."

	| r |
	r := rand next.
	r > 0.5
		ifTrue: [
			currValue := currValue + delta.
			currValue > highLimit ifTrue: [currValue := highLimit]]
		ifFalse: [
			currValue := currValue - delta.
			currValue < lowLimit ifTrue: [currValue := lowLimit]].
	currValue = lastValue ifTrue: [^ false].
	((target == nil) or: [updateSelector == nil]) ifTrue: [^ false].
	target
		perform: updateSelector
		with: scale * currValue.
	lastValue := currValue.
	^ true
