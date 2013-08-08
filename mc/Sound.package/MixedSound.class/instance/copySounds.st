copying
copySounds
	"Private! Support for copying. Copy my component sounds and settings array."

	sounds := sounds collect: [:s | s copy].
	leftVols := leftVols copy.
	rightVols := rightVols copy.
