subclass responsibilities
reset
	"Reset my encoding/decoding state to prepare to encode or decode a new sound stream."

	encodeState := self primNewState.
	decodeState := self primNewState.
