forwarding
followMaybeForwarded: objOop
	<inline: true>
	^(self isOopForwarded: objOop)
		ifTrue: [self noInlineFollowForwarded: objOop]
		ifFalse: [objOop]