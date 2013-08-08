profiling
profileAll
	"self profileAll"
	| stream |
	stream := DummyStream new.
	self nbody: 200000 "20000000" to: stream.
	self binarytrees: 15 to: stream.
	self chameneosredux: 260000 to: stream.
	self threadring: 10000000 to: stream