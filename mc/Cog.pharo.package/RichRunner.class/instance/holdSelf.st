private
holdSelf
    holdCount := holdCount + 1.
    currentTask taskHolding: true.
    ^ currentTask link