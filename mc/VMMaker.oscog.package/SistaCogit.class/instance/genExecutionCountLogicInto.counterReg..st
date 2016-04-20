bytecode generator support
genExecutionCountLogicInto: binaryBlock counterReg: counterReg
	<var: #countTripped type: #'AbstractInstruction *'>
	<inline: true>
	| counterAddress countTripped |
	counterAddress := counters + ((self sizeof: #sqInt) * counterIndex).
	self flag: 'will need to use MoveAw32:R: if 64 bits'.
	self assert: objectMemory wordSize = CounterBytes.
	self MoveAw: counterAddress R: counterReg.
	self SubCq: 16r10000 R: counterReg. "Count executed"
	"If counter trips simply abort the comparison continuing to the following
	 branch *without* writing back.  A double decrement will not trip the second time."
	countTripped := self JumpCarry: 0.
	self MoveR: counterReg Aw: counterAddress. "write back"
	binaryBlock value: counterAddress value: countTripped