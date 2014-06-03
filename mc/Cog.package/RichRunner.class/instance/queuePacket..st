private
queuePacket: packet 
    | t |
    t := self findTask: packet identity.
    t ifNil: [ ^ nil ].
    queuePacketCount := queuePacketCount + 1.
    packet link: nil.
    packet identity: currentTaskIdentity.
    ^ t addInput: packet checkPriority: currentTask