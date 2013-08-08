ephemerons
unlinkEphemeron: oop

	"During mark phase, the 'next' slot (at index =1) used as a scratch field to hold next ephemeron in queue.
	We setting it to nil, to prevent ephemerons to create unwanted dependencies"
	<inline: true>
	self storePointerUnchecked: 1 ofObject: oop withValue: self nilObject 
	