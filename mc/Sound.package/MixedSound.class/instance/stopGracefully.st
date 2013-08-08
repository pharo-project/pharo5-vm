sound generation
stopGracefully
	"End this note with a graceful decay. If the note has envelopes, determine the decay time from its envelopes."

	super stopGracefully.
	sounds do: [:s | s stopGracefully].
