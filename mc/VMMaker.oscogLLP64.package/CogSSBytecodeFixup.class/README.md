A CogSSBytecodeFixup extends CogBytecodeFixup with state to merge the stack at control-flow joins.  At a join the code generator must ensure that the stack is spilled to the same point along both branches and that the simStackPtr is correct.

Instance Variables
	simStackPtr:		<Integer>

simStackPtr
	- the simStackPtr at the jump to this fixup.  It should either agree with the incoming fixup if control continues, or replace the simStackPtr if contrl doesn't continue (the incomming control flow ended with a return)