frame access
marryFrame: theFP SP: theSP
	"Marry an unmarried frame.  This means creating a spouse context
	 initialized with a subset of the frame's state (state through the last argument)
	 that references the frame."
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<inline: false>
	^self marryFrame: theFP SP: theSP copyTemps: false