inline primitive register allocation
allocateRegistersForLowcodeInteger7ResultInteger: aBlock
	<option: #LowcodeVM>
	<inline: true>
	"Effective address 64. This instruction should not be generated on 32-bits mode"
	self abort
