utilities
append: packet head: queueHead
    | mouse link |
    packet link: nil.
    queueHead ifNil: [ ^ packet ].
    mouse := queueHead.
    [ (link := mouse link) isNil]
	whileFalse: [ mouse := link ].
    mouse link: packet.
    ^ queueHead