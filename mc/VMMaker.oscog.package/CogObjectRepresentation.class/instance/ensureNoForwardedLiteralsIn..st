compilation
ensureNoForwardedLiteralsIn: aMethodObj
	"Ensure there are no forwarded literals in the argument.
	 By default this is a noop.  Subclasses redefine as necessary."
	<inline: true>