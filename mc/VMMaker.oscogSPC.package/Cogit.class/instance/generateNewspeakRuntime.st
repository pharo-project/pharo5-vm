initialization
generateNewspeakRuntime
	<option: #NewspeakVM>
	"Generate the non-send runtime support for Newspeak: push enclosing object.
	The dynamic frequency is so low we merely call an interpreter routine."
	ceEnclosingObjectTrampoline := self genTrampolineFor: #ceEnclosingObjectAt:
										called: 'ceEnclosingObjectTrampoline'
										arg: SendNumArgsReg
										result: ReceiverResultReg.