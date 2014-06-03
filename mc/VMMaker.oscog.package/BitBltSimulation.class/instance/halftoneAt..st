memory access
halftoneAt: idx
	"Return a value from the halftone pattern."

	^self long32At: halftoneBase + (idx \\ halftoneHeight * 4)