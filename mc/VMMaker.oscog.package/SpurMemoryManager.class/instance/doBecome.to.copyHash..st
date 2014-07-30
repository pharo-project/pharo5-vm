become implementation
doBecome: obj1 to: obj2 copyHash: copyHashFlag
	| o1HashBits o2HashBits |
	o1HashBits := self rawHashBitsOf: obj1.
	o2HashBits := self rawHashBitsOf: obj2.
	self forward: obj1 to: obj2.
	copyHashFlag ifTrue: [self setHashBitsOf: obj2 to: o1HashBits].
	"obj1 is on its way out.  Remove it from the classTable"
	(o1HashBits ~= 0 and: [(self classAtIndex: o1HashBits) = obj1])
		ifTrue: [self expungeFromClassTable: obj1]
		ifFalse: [o1HashBits := 0]. "= 0 implies was not in class table"
	self deny: (self isForwarded: obj2).
	"o1HashBits ~= 0 implies obj1 was in class table and hence may have had instances.
	 Therefore o1HashBits needs to refer to obj2 (put obj2 in table at o1HashBits)."
	o1HashBits ~= 0 ifTrue:
		[o2HashBits = 0 ifTrue: "obj2 has no hash; we're free to assign one"
			[self setHashBitsOf: obj2 to: o1HashBits].
		 self classAtIndex: o1HashBits put: obj2]