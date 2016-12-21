object enumeration
objectAfter: objOop limit: limit
	"Object parsing.
	1. all objects have at least a word following the header, for a forwarding pointer.
	2. objects with an overflow size have a preceding word with a saturated numSlots.  If the word
	   following an object doesn't have a saturated numSlots field it must be a single-header object.
	   If the word following does have a saturated numSlots it must be the overflow size word."
	<inline: true>
	| followingWordAddress followingWord |
	followingWordAddress := self addressAfter: objOop.
	(self oop: followingWordAddress isGreaterThanOrEqualTo: limit) ifTrue:
		[^limit].
	self flag: #endianness.
	followingWord := self longAt: followingWordAddress.
	^followingWord >> self numSlotsFullShift = self numSlotsMask
		ifTrue: [followingWordAddress + self baseHeaderSize]
		ifFalse: [followingWordAddress]