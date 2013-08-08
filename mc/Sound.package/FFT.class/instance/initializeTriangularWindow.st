bulk processing
initializeTriangularWindow
	"Initialize the windowing function to the triangular, or Parzen, window. See F. Richard Moore, Elements of Computer Music, p. 100."

	| v |
	window := FloatArray new: n.
	0 to: (n // 2) - 1 do: [:i |
		v := i / ((n // 2) - 1).
		window at: (i + 1) put: v.
		window at: (n - i) put: v].
