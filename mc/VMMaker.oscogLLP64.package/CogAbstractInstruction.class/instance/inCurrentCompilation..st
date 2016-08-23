generate machine code
inCurrentCompilation: operand
	"Answer if operand is in the current compilation; and henced could be a candidate for pc-relative addressing."
	<inline: true>
	^(self isAnInstruction: (cogit cCoerceSimple: operand to: #'AbstractInstruction *')) "i.e. a label, which by definition will be in the current compilation."
	   or: [cogit addressIsInCurrentCompilation: operand]