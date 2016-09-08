utilities
transfer: count from: src to: dst 
	| in out lastIn |
	<inline: true>
	self flag: #Dan.  "Need to check all senders before converting this for 64 bits"
	in := src - self wordSize.
	lastIn := in + (count * self wordSize).
	out := dst - self wordSize.
	[self oop: in isLessThan: lastIn]
		whileTrue: [self
				longAt: (out := out + self wordSize)
				put: (self longAt: (in := in + self wordSize))]