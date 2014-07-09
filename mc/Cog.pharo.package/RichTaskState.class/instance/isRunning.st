testing
isRunning
    ^packetPendingIV not and: [taskWaiting not and: [taskHolding not]]