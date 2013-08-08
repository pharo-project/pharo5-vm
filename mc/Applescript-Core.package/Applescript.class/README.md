I represent a Squeak front-end to Applescript.  My instances represent either compiled scripts, contexts or both.  My instances maintain separately the original source code from which I was compiled, and then a CompiledApplescript corresponding to that source code in its "current state."  I provide facilities for executing my scripts, alone or in various contexts, as well as for recompiling my script to restore the script to its initial state (if the script bears context information).

Examples:

	To execute some text:

		Applescript doIt: 'beep 3'

	To compile code into a script object (for MUCH faster execution of repeated tasks, and to maintain state between execution), and then to execute the code:

		|aVariable|
		aVariable _ Applescript on: '
			property sam: 0
			set sam to sam + 1
			beep sam'.
		aVariable doIt

	Other. somewhat more general operations

		Applescript doIt: aString mode: anInteger
		Applescript doIt: aString in: aContext mode: anInteger

		s _ Applescript on: aString mode: anInteger

		s doItMode: anInteger
		s doItIn: aContext
		s doItIn: aContext mode: anInteger
		s recompile

	Also note the examples in the class side of me.
		