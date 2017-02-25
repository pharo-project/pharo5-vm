testing
isPCRelativeValueLoad: instr
	<var: 'instr' type: #'unsigned int'>
	"add xx, pc, blah or sub xx, pc, blah"
	^(instr >> 16) = 16rE28F or: [instr >> 16 = 16rE24F]