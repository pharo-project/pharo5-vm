access
coeffs: coeffArray
	"Initialize this instance from the given coeff array (including header)."
	| header strm |
	strm := ReadStream on: coeffArray.
	header := strm next: 4.
	self nSamples: header first nLevels: header second.
	self setAlpha: header third beta: header fourth.
	1 to: nLevels do: [:i | transform at: i*2 put: (strm next: (transform at: i*2) size)].
	transform at: nLevels*2-1 put: (strm next: (transform at: nLevels*2-1) size).
	strm atEnd ifFalse: [self error: 'Data size error'].
