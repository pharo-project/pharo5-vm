initialization
generateTracingTrampolines
	"Generate trampolines for tracing.  In the simulator we can save a lot of time
	 and avoid noise instructions in the lastNInstructions log by short-cutting these
	 trampolines, but we need them in the real vm."
	ceTraceLinkedSendTrampoline :=
		self genSafeTrampolineFor: #ceTraceLinkedSend:
			called: 'ceTraceLinkedSendTrampoline'
			arg: ReceiverResultReg.
	ceTraceBlockActivationTrampoline :=
		self genTrampolineFor: #ceTraceBlockActivation
			called: 'ceTraceBlockActivationTrampoline'.
	ceTraceStoreTrampoline :=
		self genSafeTrampolineFor: #ceTraceStoreOf:into:
			called: 'ceTraceStoreTrampoline'
			arg: ClassReg
			arg: ReceiverResultReg.
	self cCode: [] inSmalltalk:
		[ceTraceLinkedSendTrampoline := self simulatedTrampolineFor: #ceShortCutTraceLinkedSend:.
		 ceTraceBlockActivationTrampoline := self simulatedTrampolineFor: #ceShortCutTraceBlockActivation:.
		 ceTraceStoreTrampoline := self simulatedTrampolineFor: #ceShortCutTraceStore:]