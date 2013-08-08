sound library
soundNamed: soundName put: aSound

	Sounds at: soundName put: aSound.
	AbstractSound updateScorePlayers.
