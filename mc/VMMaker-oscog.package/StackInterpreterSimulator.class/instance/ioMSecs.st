I/O primitives support
ioMSecs
	"Return the value of the millisecond clock."
	"NOT.  Actually, we want something a lot slower and, for exact debugging,
	something more repeatable than real time.  I have an idea: use the byteCount... (di 7/1/2004 13:55)"

	^self microsecondsToMilliseconds: self ioUTCMicroseconds
	
"At 20k bytecodes per second, this gives us about 200 ticks per second, or about 1/5 of what you'd expect for the real time clock.  This should still service events at one or two per second"