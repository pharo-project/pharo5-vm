primitive support
success: successBoolean
	"Set the state of the primitive failure code/success flag, iff successBoolean
	 is false. If primFailCode is non-zero a primitive has failed.  If primFailCode
	 is greater than one then its value indicates the reason for failure."

	"Use returnTypeC: #sqInt because that's the way it is defined in sq.h.
	 Use no explicit return so that Slang doesn't fail an inlining type-check when
	 a primitive with return type void uses ^self success: false to exit."
	<returnTypeC: #sqInt>
	<inline: true>
	successBoolean ifFalse:
		["Don't overwrite an error code that has already been set."
		 self successful ifTrue:
			[primFailCode := 1]]