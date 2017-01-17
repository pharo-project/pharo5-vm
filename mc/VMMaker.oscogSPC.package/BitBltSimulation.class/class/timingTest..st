testing
timingTest: extent 
	"BitBltSimulation timingTest: 640@480"
	| f f2 map |
	f := Form extent: extent depth: 8.
	f2 := Form extent: extent depth: 8.
	map := Bitmap new: 1 << f2 depth.
	^ Array
		with: (Time millisecondsToRun: [100 timesRepeat: [f fillWithColor: Color white]])
		with: (Time millisecondsToRun: [100 timesRepeat: [f copy: f boundingBox from: 0 @ 0 in: f2 rule: Form over]])
		with: (Time millisecondsToRun: [100 timesRepeat: [f copyBits: f boundingBox from: f2 at: 0 @ 0 colorMap: map]])