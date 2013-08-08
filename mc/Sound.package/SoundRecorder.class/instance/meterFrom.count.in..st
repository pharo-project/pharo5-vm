private
meterFrom: start count: count in: buffer
	"Update the meter level with the maximum signal level in the given range of the given buffer."

	| last max sample |
	count = 0 ifTrue: [^ self].  "no new samples"
	last := start + count - 1.
	max := 0.
	start to: last do: [:i |
		sample := buffer at: i.
		sample < 0 ifTrue: [sample := sample negated].
		sample > max ifTrue: [max := sample]].
	meterLevel := max.
