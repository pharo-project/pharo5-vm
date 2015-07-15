submorphs - simulator display view
displayViewLayoutFrame 
	| squeakJSFrame buttonFrame simulatorFrame|
	"if any Morphic guru's understand layouts and offsets, please fix this. tty"
	buttonFrame := self buttonRowLayoutFrame.
	squeakJSFrame := self squeakJSRowLayoutFrame.
	simulatorFrame := self simulatorLayoutFrame.
	^LayoutFrame fractions: (0@0 corner: 1@1) 
				    offsets: (0@(buttonFrame bottomOffset) corner: simulatorFrame leftOffset@squeakJSFrame topOffset)