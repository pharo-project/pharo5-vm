composition
pruneFinishedSounds
	"Remove any sounds that have been completely played."

	| newSnds |
	(currentIndex > 1 and: [currentIndex < sounds size]) ifFalse: [^ self].
	newSnds := sounds copyFrom: currentIndex to: sounds size.
	currentIndex := 1.
	sounds := newSnds.
