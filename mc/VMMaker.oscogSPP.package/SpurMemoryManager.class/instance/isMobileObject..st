object enumeration
isMobileObject: objOop
	"Answer if objOop should be moved during compaction.  Non-objects
	 (free chunks & bridges), forwarders and pinned objects are excluded."
	| classIndex |
	<inline: true>
	classIndex := self classIndexOf: objOop.
	self assert: ((self long64At: objOop) ~= 0
				  and: [classIndex < (numClassTablePages * self classTablePageSize)]).
	^classIndex > self isForwardedObjectClassIndexPun
	  and: [(self isPinned: objOop) not]