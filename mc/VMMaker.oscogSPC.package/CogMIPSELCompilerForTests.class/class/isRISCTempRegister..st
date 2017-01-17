as yet unclassified
isRISCTempRegister: reg
	"For tests to filter-out bogus values left in the RISCTempRegister, if any."
	^reg = AT
		or: [reg = Cmp
		or: [reg = Overflow
		or: [reg = BranchTemp]]]