instructions - control
branchNotEqual: instruction
	| rsValue rtValue |
	self assert: inDelaySlot not.
	rsValue := self signedRegister: instruction rs.
	rtValue := self signedRegister: instruction rt.
	self doBranch: rsValue ~= rtValue offset: instruction signedImmediate << 2.