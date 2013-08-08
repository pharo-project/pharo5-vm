debug printing
printFrameOop: name at: address
	<inline: false>
	self printFrameOop: name obj: (stackPages longAt: address) at: address