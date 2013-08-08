all
scroll
	image copy: (scrollDelta@0 extent: (image width-scrollDelta)@image height)
			from: image to: 0@0 rule: Form over.
	lastX := lastX - scrollDelta.
	self changed