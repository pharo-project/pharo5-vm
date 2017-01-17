debug support
cloneSimulationWindow
	| label |
	label := 'Clone of ', (displayView containingWindow label allButFirst: 'Simulation of ' size).
	^self cloneSimulation openAsMorph
		setLabel: label;
		yourself