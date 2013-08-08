sound generation
doControl

	super doControl.
	1 to: sounds size do: [:i | (sounds at: i) doControl].
