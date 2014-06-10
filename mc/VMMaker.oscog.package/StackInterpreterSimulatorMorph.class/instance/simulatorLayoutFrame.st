submorphs - simulator panel
simulatorLayoutFrame 
	| squeakJSFrame buttonFrame |
	"I don't understand offsets in the LayoutFrame. I just fiddled until it looked ok. If anybody knows what they are doing, please refactor."
	self flag: 'tty'.
	buttonFrame := self buttonRowLayoutFrame.
	squeakJSFrame := self squeakJSRowLayoutFrame.
	^LayoutFrame fractions: (0.7@0 corner: 1@squeakJSFrame topOffset) 
				    offsets: (0@(buttonFrame bottomOffset) corner: 0.70@squeakJSFrame topOffset)
