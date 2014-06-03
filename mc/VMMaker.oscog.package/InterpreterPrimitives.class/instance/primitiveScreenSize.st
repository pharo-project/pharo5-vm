I/O primitives
primitiveScreenSize
	"Answer a point indicating the current size of the Smalltalk window.
	 Currently there is a limit of 65535 in each direction because the
	 point is encoded into a single 32bit value in the image header.
	 This might well become a problem one day"
	self
		cCode:
			[| pointWord |
			 pointWord := self ioScreenSize.
			 self pop: 1
				thenPush: (self makePointwithxValue: (pointWord >> 16 bitAnd: 65535)
								yValue: (pointWord bitAnd: 65535))]
		inSmalltalk:
			[| size |
			"Default to a reasonable size for simulation, unless the window has opened,
			 in which case allow the screen to be as large as the simulation window"
			 size := (self displayView notNil and: [self savedWindowSize notNil])
						ifTrue: [self desiredDisplayExtent]
						ifFalse: [self desiredDisplayExtent min: 800@640].
			 self pop: 1 thenPush: (self makePointwithxValue: size x yValue: size y)]