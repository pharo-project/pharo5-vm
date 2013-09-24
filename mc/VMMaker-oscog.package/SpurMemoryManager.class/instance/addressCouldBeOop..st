debug support
addressCouldBeOop: address 
	^(self isImmediate: address)
	  or: [self addressCouldBeObj: address]