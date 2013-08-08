other
trimAttacks: threshold
	"Trim 'silence' off the initial attacks all my samples."

	(sustainedSoft, sustainedLoud, staccatoSoft, staccatoLoud) do: [:snd |
		snd leftSamples: (self trimAttackOf: snd leftSamples threshold: threshold).
		snd isStereo ifTrue: [
			snd rightSamples:
				(self trimAttackOf: snd rightSamples threshold: threshold)]].
