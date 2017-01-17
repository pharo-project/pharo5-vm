accessing
isImmediateClass: classOop
	"Can't rely on the host image; may be running on SqueakV3.  hence..."
	^#(Character SmallInteger SmallFloat) includes: (self objectForOop: classOop) name