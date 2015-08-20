accessing-abstract
callerABISavedSmashRegisterAccessors
"limited list of registers to clear out when simulating a naBI call; we need R1 sometimes since many abi calls return 2 results or maybe a 64bit dual-reg value, and LR has to be left alone becasue a leaf call doesn't push it"
	^#( r2: r3: )