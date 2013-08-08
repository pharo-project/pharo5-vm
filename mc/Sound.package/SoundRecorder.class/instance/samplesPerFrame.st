private
samplesPerFrame
	"Can be overridden to quantize buffer size for, eg, fixed-frame codecs"

	codec == nil
		ifTrue: [^ 1]
		ifFalse: [^ codec samplesPerFrame]