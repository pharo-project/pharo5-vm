primitive support
primitiveFail
	"Set general (unspecified) primitive failure.  Don't overwrite an error code that has already been set."

	"Use returnTypeC: #sqInt because that's the way it is defined in sq.h.
	 Use no explicit return so that Slang doesn't fail an inlining type-check when
	 a primitive with return type void uses ^self primitiveFail to exit."
	<api>
	<returnTypeC: #sqInt>
	<inline: true>
	self successful ifTrue:
		[primFailCode := 1]