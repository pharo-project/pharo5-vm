debug support
addressCouldBeOop: address
	<api>
	"Answer if address appears to be that of either a SmallInteger or an object.
	 For code disassembly and assertions."
	^(self isIntegerObject: address)
	   or: [self addressCouldBeObj: address]