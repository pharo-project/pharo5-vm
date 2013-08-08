copying
transformSounds: tfmBlock
	"Private! Support for copying. Copy my component sounds."

	sounds := sounds collect: [:s | tfmBlock value: s].
