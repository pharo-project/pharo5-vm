UI
openAsSimulatorMorph
	"Open a morphic view on this simulation. ala Bert Freudenberg's
	SqueakJS http://lively-web.org/users/bert/squeak.html	"
	| localImageName borderWidth window |
	localImageName := imageName
							ifNil: [' synthetic image']
							ifNotNil: [FileDirectory default localNameFor: imageName].

	transcript := TranscriptStream on: (String new: 10000).

	window := SimulatorMorph	
					withVMSimulator: self 
					title: 'Simulation of ' , localImageName, ' (beta)'
					transcript: transcript.				

	borderWidth := [SimulatorMorph borderWidth] "Squeak 4.1"
						on: MessageNotUnderstood
						do: [:ex | 0].
	"3.8"
	borderWidth := borderWidth + window borderWidth.
	window openInWorldExtent: (self desiredDisplayExtent + (2 * borderWidth) + (0 @ window labelHeight) * (1 @ (1 / 0.8))) rounded.
	^window