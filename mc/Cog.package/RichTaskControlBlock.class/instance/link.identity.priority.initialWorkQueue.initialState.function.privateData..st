initialize
link: aLink identity: anIdentity priority: aPriority initialWorkQueue: anInitialWorkQueue initialState: anInitialState function: aBlock privateData: aPrivateData 
    link := aLink.
    identity := anIdentity.
    priority := aPriority.
    input := anInitialWorkQueue.
    packetPendingIV := anInitialState isPacketPending.
    taskWaiting := anInitialState isTaskWaiting.
    taskHolding := anInitialState isTaskHolding.
    function := aBlock.
    handle := aPrivateData