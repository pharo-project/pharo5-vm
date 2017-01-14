accessing
morph
	"I need the bounds of my morph for filtering mouse events.
       If there is a canned way of doing this besides this tight binding to my SimulatorMorph,
	then please refactor me.

      see my protocol event-forwarding for the gory details"
	self flag:'tty'.
	^morph.