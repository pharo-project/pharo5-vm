composition
delayedBy: seconds
	"Return a composite sound consisting of a rest for the given amount of time followed by the receiver."

	^ (RestSound dur: seconds), self
