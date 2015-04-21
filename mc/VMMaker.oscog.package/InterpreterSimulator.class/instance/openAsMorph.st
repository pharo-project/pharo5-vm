UI
openAsMorph
	"Open a morphic view on this simulation."
	| window localImageName |
	localImageName := imageName
							ifNotNil: [FileDirectory default localNameFor: imageName]
							ifNil: [' synthetic image'].
	window := (SystemWindow labelled: 'Simulation of ' , localImageName) model: self.

	window addMorph: (displayView := ImageMorph new image: displayForm)
		frame: (0@0 corner: 1@0.8).

	transcript := TranscriptStream on: (String new: 10000).
	window addMorph: (PluggableTextMorph on: transcript text: nil accept: nil
			readSelection: nil menu: #codePaneMenu:shifted:)
		frame: (0@0.8 corner: 0.7@1).

	window addMorph: (PluggableTextMorph on: self
						text: #byteCountText accept: nil) hideScrollBarsIndefinitely
		frame: (0.7@0.8 corner: 1@1).

	window openInWorld.
	^window