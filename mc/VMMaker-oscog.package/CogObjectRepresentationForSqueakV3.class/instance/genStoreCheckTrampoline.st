initialization
genStoreCheckTrampoline
	"Call noteAsRoot: with the object stored into"
	^cogit
		genTrampolineFor: #ceStoreCheck:
		called: 'ceStoreCheckTrampoline'
		arg: ReceiverResultReg
		result: cogit returnRegForStoreCheck