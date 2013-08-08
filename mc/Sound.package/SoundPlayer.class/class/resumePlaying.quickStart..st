playing
resumePlaying: aSound quickStart: quickStart
	"Start playing the given sound without resetting it; it will resume playing from where it last stopped. If quickStart is true, then try to start playing the given sound immediately."

	| doQuickStart |
	SoundService soundEnabled ifFalse: [^ self].
	doQuickStart := quickStart.
	self soundQuickStart ifFalse: [doQuickStart := false].
	PlayerProcess == nil ifTrue: [
		self canStartPlayer ifFalse: [^ self].
		^self startUpWithSound: aSound].

	PlayerSemaphore critical: [
		(ActiveSounds includes: aSound)
			ifTrue: [doQuickStart := false]
			ifFalse: [
				doQuickStart ifFalse: [ActiveSounds add: aSound]]].

	"quick-start the given sound, unless the sound player has just started"
	doQuickStart ifTrue: [self startPlayingImmediately: aSound].
