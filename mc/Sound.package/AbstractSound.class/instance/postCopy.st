copying
postCopy
	"A sound should copy all of the state needed to play itself, allowing two copies of a sound to play at the same time. These semantics require a recursive copy but only down to the level of immutable data. For example, a SampledSound need not copy its sample buffer. Subclasses overriding this method should include a resend to super."

	super postCopy.
	self copyEnvelopes
