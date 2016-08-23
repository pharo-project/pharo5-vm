geometry
extent: aPoint
	"Override to restore the default resizing behaviour."
	^self perform: #extent: withArguments: {aPoint} inSuperclass: ImageMorph superclass