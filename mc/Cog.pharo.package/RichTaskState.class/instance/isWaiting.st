testing
isWaiting
    ^packetPendingIV not and: [taskWaiting and: [taskHolding not]]