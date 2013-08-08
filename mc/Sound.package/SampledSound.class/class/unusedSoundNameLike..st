sound library
unusedSoundNameLike: desiredName
	"Pick an unused sound name based on the given string. If necessary, append digits to avoid name conflicts with existing sounds."
	"SampledSound unusedSoundNameLike: 'chirp'"

	| newName i |
	newName := desiredName.
	i := 2.
	[SoundLibrary includesKey: newName] whileTrue: [
		newName := desiredName, i printString.
		i := i + 1].
	^ newName
