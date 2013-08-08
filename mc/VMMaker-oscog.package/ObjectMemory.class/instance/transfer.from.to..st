utilities
transfer: count from: src to: dst 
	| in out lastIn |
	<inline: true>
	self flag: #Dan.  "Need to check all senders before converting this for 64 bits"
	in := src - BytesPerWord.
	lastIn := in + (count * BytesPerWord).
	out := dst - BytesPerWord.
	[self oop: in isLessThan: lastIn]
		whileTrue: [self
				longAt: (out := out + BytesPerWord)
				put: (self longAt: (in := in + BytesPerWord))]