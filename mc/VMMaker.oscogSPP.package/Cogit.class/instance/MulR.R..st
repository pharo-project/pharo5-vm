abstract instructions
MulR: reg1 R: reg2
	"Multiplication is a little weird on some processors.  Defer to the backEnd
	 to allow it to generate any special code it may need to."
	<inline: true>
	^backEnd genMulR: reg1 R: reg2