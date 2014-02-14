UI
openAsMorphNoTranscript
	"Open a morphic view on this simulation."
	| window localImageName |
	localImageName := imageName asFileReference basename.
	window := (SystemWindow labelled: 'Simulation of ' , localImageName) model: self.

	window addMorph: (displayView := ImageMorph new image: displayForm)
		frame: (0@0 corner: 1@0.95).

	window addMorph: (PluggableTextMorph on: self
						text: #byteCountText accept: nil) hideScrollBarsIndefinitely
		frame: (0@0.95 corner: 1@1).

	window openInWorldExtent: (self desiredDisplayExtent
								+ (2 * window borderWidth)
								+ (0@window labelHeight)
								* (1@(1/0.95))) rounded