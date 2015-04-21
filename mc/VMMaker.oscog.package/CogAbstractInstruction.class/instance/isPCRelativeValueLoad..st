testing
isPCRelativeValueLoad: instr
	"add ip, pc, blah->  '16rE28FC000'
	 sub ip, pc, blah -> '16rE24FC000'"
	^(instr bitAnd: 16rFFFFF000) = 16rE28FC000
	  or: [(instr bitAnd: 16rFFFFF000) = 16rE24FC000]