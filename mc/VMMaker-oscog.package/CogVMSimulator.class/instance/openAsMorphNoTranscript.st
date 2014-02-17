UI
openAsMorphNoTranscript
	"Open a morphic view on this simulation."
	| localImageName theWindow |
	localImageName := imageName asFileReference basename.
	theWindow := (SystemWindow labelled: 'Simulation of ' , localImageName) model: self.

	theWindow addMorph: (displayView := ImageMorph new image: displayForm)
		frame: (0@0 corner: 1@0.95).

	theWindow addMorph: (PluggableTextMorph on: self
						text: #byteCountText accept: nil
						readSelection: nil menu: #utilitiesMenu:) hideScrollBarsIndefinitely
		frame: (0@0.95 corner: 1@1).

	theWindow openInWorldExtent: (self desiredDisplayExtent
								+ (2 * theWindow borderWidth)
								+ (0@theWindow labelHeight)
								* (1@(1/0.95))) rounded