simulation stack
ssNativeFlushTo: index
	<option: #LowcodeVM>
	| loadedPointer allocatedScratchRegister |
	simNativeSpillBase <= index ifTrue: [
		loadedPointer := false.
		allocatedScratchRegister := false.

		(simNativeSpillBase max: 0) to: index do:  [:i|
			loadedPointer ifFalse: [
				self MoveMw: self frameOffsetOfNativeFramePointer r: FPReg R: TempReg.
				loadedPointer := true.
			].

			((self simNativeStackAt: i) spillingNeedsScratchRegister and: [allocatedScratchRegister not ]) ifTrue: [
				self PushR: FPReg.
				allocatedScratchRegister := true.
			].

			(self simNativeStackAt: i)
				ensureSpilledSP: TempReg scratchRegister: FPReg
		].

		simNativeSpillBase := index + 1.

		allocatedScratchRegister ifTrue: [
			self PopR: FPReg.
		].

		loadedPointer ifTrue: [
			self SubCq: simNativeStackSize R: TempReg.
			self MoveR: TempReg Mw: self frameOffsetOfNativeStackPointer r: FPReg.
		]
	]