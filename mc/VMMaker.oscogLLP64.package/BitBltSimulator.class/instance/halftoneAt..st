memory access
halftoneAt: idx

	^self
		cCode: [(halftoneBase + (idx \\ halftoneHeight * 4)) long32At: 0]
		inSmalltalk: [super halftoneAt: idx]