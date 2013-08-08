utilities
pitchTable
	"AbstractSound pitchTable"

	| out i |
	out := WriteStream on: (String new: 1000).
	i := 12.
	0 to: 8 do: [:octave |
		#(c 'c#' d eb e f fs g 'g#' a bf b) do: [:noteName | | note |
			note := noteName, octave printString.
			out nextPutAll: note; tab.
			out nextPutAll: i printString; tab.
			out nextPutAll: (AbstractSound pitchForName: note) printString; cr.
			i := i + 1]].
	^ out contents
