free space
setObjectFree: objOop
	"Mark an object free, but do not add it to the free lists.  The wrinkle here
	 is that we don't tolerate a zero-slot count in a free object so that the
	 (self long64At: objOop) ~= 0 assert in isEnumerableObject: isn't triggered."
		 
	(self rawNumSlotsOf: objOop) = 0 ifTrue:
		[self rawNumSlotsOf: objOop put: 1].
	self setFree: objOop