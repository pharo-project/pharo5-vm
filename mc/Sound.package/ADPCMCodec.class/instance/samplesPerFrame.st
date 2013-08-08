codec stuff
samplesPerFrame
	"Answer the number of sound samples per compression frame."

	frameSizeMask > 0 ifTrue: [^ frameSizeMask + 1].
	^ 8  "frame size when there are no running headers"
