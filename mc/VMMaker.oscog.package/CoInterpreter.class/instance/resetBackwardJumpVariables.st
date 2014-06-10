jump bytecodes
resetBackwardJumpVariables
	"Reference these variables from outside interpret to avoid them being localised to interpret.
	 Oh the hacks we commit for Slang..."
	<cmacro: '() /* nada */'>
	<inline: #false>
	lastBackwardJumpMethod := lastBackwardJumpMethod.
	backwardJumpCount := backwardJumpCount