sound tracks
sonogramMorph: height from: start to: stop nPoints: nPoints
	"FYI:  It is very cool that we can do this, but for sound tracks on a movie,
	simple volume is easier to read, easier to scale, and way faster to compute.
	Code preserved here just in case it makes a useful example."
	"In an inspector of a samplesSound...
		self currentWorld addMorph: (self sonogramMorph: 32 from: 1 to: 50000 nPoints: 256)
	"
	| fft sonogramMorph width |
	fft := FFT new: nPoints.
	width := stop-start//nPoints.
	sonogramMorph := Sonogram new
			extent: width@height
			minVal: 0.0
			maxVal: 1.0
			scrollDelta: width.
	start to: stop-nPoints by: nPoints do:
		[:i | | data |
		data := fft transformDataFrom: samples startingAt: i.
		data := data collect: [:v | v sqrt].  "square root compresses dynamic range"
		data /= 200.0.
		sonogramMorph plotColumn: data].
	^ sonogramMorph
	
