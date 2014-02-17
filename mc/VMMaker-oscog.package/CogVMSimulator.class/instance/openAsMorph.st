UI
openAsMorph
	"Open a morphic view on this simulation."
	| localImageName borderWidth theWindow |
	localImageName := imageName asFileReference basename.
	theWindow := (SystemWindow labelled: 'Simulation of ', localImageName) model: self.

	theWindow addMorph: (displayView := ImageMorph new image: displayForm)
		frame: (0@0 corner: 1@0.8).

	transcript := ThreadSafeTranscript new.
	theWindow addMorph: (PluggableTextMorph
							on: transcript text: nil accept: nil
							readSelection: nil menu: #codePaneMenu:shifted:)
			frame: (0@0.8 corner: 0.7@1).
	theWindow addMorph: (PluggableTextMorph on: self
						text: #byteCountText accept: nil
						readSelection: nil menu: #utilitiesMenu:) hideScrollBarsIndefinitely
			frame: (0.7@0.8 corner: 1@1).

	borderWidth := [SystemWindow borderWidth] "Squeak 4.1"
						on: MessageNotUnderstood
						do: [:ex| 0]. "3.8"
	borderWidth := borderWidth + theWindow borderWidth.
	theWindow openInWorldExtent: (self desiredDisplayExtent
								+ (2 * borderWidth)
								+ (0@theWindow labelHeight)
								* (1@(1/0.8))) rounded