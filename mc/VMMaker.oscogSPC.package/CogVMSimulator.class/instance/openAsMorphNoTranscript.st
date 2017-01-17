UI
openAsMorphNoTranscript
	"Open a morphic view on this simulation."
	| localImageName borderWidth window |
	localImageName := imageName
							ifNotNil: [FileDirectory default localNameFor: imageName]
							ifNil: [' synthetic image'].
	window := (SystemWindow labelled: 'Simulation of ', localImageName) model: self.
	window paneColor: self windowColorToUse.

	window addMorph: (displayView := SimulatorImageMorph new image: displayForm)
			frame: (0@0 corner: 1@0.95).
	displayView activeHand addEventListener: self.
	eventTransformer := SimulatorEventTransformer new.

	window addMorph: (PluggableTextMorph on: self
						text: #byteCountText accept: nil
						readSelection: nil menu: #utilitiesMenu:) hideScrollBarsIndefinitely
		frame: (0@0.95 corner: 1@1).

	borderWidth := [SystemWindow borderWidth] "Squeak 4.1"
						on: MessageNotUnderstood
						do: [:ex| 0]. "3.8"
	borderWidth := borderWidth + window borderWidth.
	window openInWorldExtent: (self desiredDisplayExtent
								+ (2 * borderWidth)
								+ (0@window labelHeight)
								* (1@(1/0.95))) rounded