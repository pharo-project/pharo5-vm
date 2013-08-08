instance creation
new: anInteger
	"See the comment in newMonoSampleCount:. To avoid confusion, it is best to create new instances using newMonoSampleCount: or newStereoSampleCount:."

	^ self newMonoSampleCount: anInteger
