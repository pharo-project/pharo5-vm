initialization
duration: seconds
	"Scale my envelopes to the given duration. Subclasses overriding this method should include a resend to super."

	envelopes do: [:e | e duration: seconds].
