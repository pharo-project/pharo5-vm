generate machine code - support
moveCw: constant intoR: destReg
	"Emit a load of aWord into destReg.  Answer the number of bytes of machine code generated."
	 <var: 'constant' type: #usqInt>
	<inline: true>
	^self subclassResponsibility