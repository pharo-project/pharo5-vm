testing
isWaitingWithPacket
    ^packetPendingIV and: [taskWaiting and: [taskHolding not]]