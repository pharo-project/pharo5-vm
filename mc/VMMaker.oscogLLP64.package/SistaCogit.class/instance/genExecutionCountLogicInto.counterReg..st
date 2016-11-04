bytecode generator support
genExecutionCountLogicInto: binaryBlock counterReg: counterReg
	<var: #countTripped type: #'AbstractInstruction *'>
	<inline: true>
	| counterAddress countTripped |
	counterAddress := counters + ((self sizeof: #sqInt) * counterIndex).
	self assert: objectMemory wordSize = CounterBytes.
	self MoveA32: counterAddress R: counterReg.
	self SubCq: 16r10000 R: counterReg. "Count executed"
	"If counter trips simply abort the comparison continuing to the following
	 branch *without* writing back.  A double decrement will not trip the second time."
	countTripped := self JumpCarry: 0.
	self MoveR: counterReg A32: counterAddress. "write back"
	binaryBlock value: counterAddress value: countTripped