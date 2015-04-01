simulation
halftoneAt: idx

	^ (halftoneBase + (idx \\ halftoneHeight * 4)) long32At: 0