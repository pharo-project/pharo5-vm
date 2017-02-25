enilopmarts
executeCogBlock: cogMethod closure: closure mayContextSwitch: mayContextSwitch
	"self shortPrintFrameAndCallers: framePointer"
	"(#(16r56E90 16r133D0) includes: cogMethod asInteger)  ifTrue: [self halt]."
	"self halt."
	^super executeCogBlock: cogMethod closure: closure mayContextSwitch: mayContextSwitch