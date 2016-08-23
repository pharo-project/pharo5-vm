I/O primitives support
ioUTCMicroseconds
	"Return the value of the microsecond clock."
	"NOT.  Actually, we want something a lot slower and, for exact debugging,
	 something more repeatable than real time.  Dan had an idea: use the byteCount...
	 We increment byteCount in stackLimitFromMachineCode and a real machine
	 can easily run e.g. nfib at 6e7 / second, which this would be 1 usec ~= 60 byteCounts.
	 Use 10 byteCounts per usec by default; see CogVMSimulator class>>initializeWithOptions:objectMemoryClass:"

	^byteCount // ByteCountsPerMicrosecond + startMicroseconds
	
	"Dan:
	 At 20k bytecodes per second, this gives us about 200 ticks per second, or about 1/5
	 of what you'd expect for the real time clock.  This should still service events at one or
	 two per second"