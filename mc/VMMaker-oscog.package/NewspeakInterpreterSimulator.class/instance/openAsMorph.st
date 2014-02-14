UI
openAsMorph
	"Open a morphic view on this simulation."
	| window localImageName |
	localImageName := imageName asFileReference basename.
	window := (SystemWindow labelled: 'Simulation of ', localImageName) model: self.

	window addMorph: (displayView := ImageMorph new image: displayForm)
		frame: (0@0 corner: 1@0.8).

	transcript := ThreadSafeTranscript new.
	window addMorph: (PluggableTextMorph
							on: transcript text: nil accept: nil
							readSelection: nil menu: #codePaneMenu:shifted:)
			frame: (0@0.8 corner: 0.7@1).

	window addMorph: (PluggableTextMorph on: self
						text: #byteCountText accept: nil
						readSelection: nil menu: #utilitiesMenu:) hideScrollBarsIndefinitely
			frame: (0.7@0.8 corner: 1@1).

	window openInWorldExtent: (self desiredDisplayExtent
								+ (2 * window borderWidth)
								+ (0@window labelHeight)
								* (1@(1/0.8))) rounded