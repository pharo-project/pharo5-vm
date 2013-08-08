access
coeffs
	"Return all coefficients needed to reconstruct the original samples"
	| header csize strm |
	header := Array with: nSamples with: nLevels with: alpha with: beta.
	csize := header size.
	1 to: nLevels do: [:i | csize := csize + (transform at: i*2) size].
	csize := csize + (transform at: nLevels*2-1) size.
	coeffs := Array new: csize.
	strm := WriteStream on: coeffs.
	strm nextPutAll: header.
	1 to: nLevels do: [:i | strm nextPutAll: (transform at: i*2)].
	strm nextPutAll: (transform at: nLevels*2-1).
	^ coeffs