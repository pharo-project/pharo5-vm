initialization
generateTracingTrampolines
	"Generate trampolines for tracing.  In the simulator we can save a lot of time
	 and avoid noise instructions in the lastNInstructions log by short-cutting these
	 trampolines, but we need them in the real vm."
	ceTraceLinkedSendTrampoline
		:= self cCode:
					[self genSafeTrampolineFor: #ceTraceLinkedSend:
						called: 'ceTraceLinkedSendTrampoline'
						arg: ReceiverResultReg]
				inSmalltalk:
					[self simulatedTrampolineFor: #ceShortCutTraceLinkedSend:].
	ceTraceBlockActivationTrampoline
		:= self cCode:
					[self genTrampolineFor: #ceTraceBlockActivation
						called: 'ceTraceBlockActivationTrampoline']
				inSmalltalk:
					[self simulatedTrampolineFor: #ceShortCutTraceBlockActivation:].
	ceTraceStoreTrampoline
		:= self cCode:
					[self genSafeTrampolineFor: #ceTraceStoreOf:into:
						called: 'ceTraceStoreTrampoline'
						arg: TempReg
						arg: ReceiverResultReg]
				inSmalltalk:
					[self simulatedTrampolineFor: #ceShortCutTraceStore:]