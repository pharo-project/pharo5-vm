utilities
lowPassFiltered
	"Answer a simple low-pass filtered copy of this buffer. Assume it is monophonic."

	| sz out last this |
	sz := self monoSampleCount.
	out := self shallowCopy.
	last := self at: 1.
	2 to: sz do: [:i |
		this := self at: i.
		out at: i put: (this + last) // 2.
		last := this].
	^ out
