sound tracks
volumeForm: height from: start to: stop nSamplesPerPixel: nPerPixel
	"Note: nPerPixel can be Integer or Float for pixel-perfect alignment."
	"In an inspector of a samplesSound...
		self currentWorld addMorph: (ImageMorph new image:
			(self volumeForm: 32 from: 1 to: samples size nSamplesPerPixel: 225))
	"
	| volPlot width max |
	width := stop-start//nPerPixel.
	volPlot := Form extent: width@height.
	(start max: 1) to: (stop min: samples size)-nPerPixel by: nPerPixel do:
		[:i | | sample min vol | min:= max:= 0.
		i asInteger to: (i+nPerPixel-1) asInteger by: 4 do:  "by: 4 makes it faster yet looks the same"
			[:j | sample := samples at: j.
			sample < min ifTrue: [min := sample].
			sample > max ifTrue: [max := sample]].
		vol := (max - min) * height // 65536.
		volPlot fillBlack: ((i-start//nPerPixel) @ (height-vol//2) extent: 1@(vol+1))].
	^ volPlot
	
