system control primitives
primitiveHighResClock
	"Return the value of the high resolution clock if this system has any. The exact frequency of the high res clock is undefined specifically so that we can use processor dependent instructions (like RDTSC). The only use for the high res clock is for profiling where we can allocate time based on sub-msec resolution of the high res clock. If no high-resolution counter is available, the platform should return zero."
	<export: true>
	self pop: 1.
	self push: (self positive64BitIntegerFor: self ioHighResClock).