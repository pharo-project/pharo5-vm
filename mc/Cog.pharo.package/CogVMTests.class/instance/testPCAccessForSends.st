tests
testPCAccessForSends
	"self new testPCAccessForSends"
	| runningOnCogit |
	runningOnCogit := self runningOnCogit.
	#("Method-level pc maping"
		( '{ thisContext pc.
			thisContext xrayIsExecutingMachineCode.
			thisContext method }'
			pc)
		( '{ thisContext perform: #perform:withArguments: with: #pc with: Array new.
			thisContext xrayIsExecutingMachineCode.
			thisContext method }'
			perform:with:with: )
		( '{ [:ctxt :msg :ign1| ctxt perform: msg] value: thisContext value: #pc value: nil.
			thisContext xrayIsExecutingMachineCode.
			thisContext method }'
			value:value:value: )
	   "Block-level pc maping"
		( '[:method|
			{ thisContext pc.
			  thisContext xrayIsExecutingMachineCode.
			  method } ] value: thisContext method'
			pc)
		( '[:method|
			{ (thisContext perform: #perform:withArguments: with: #pc with: Array new).
			  thisContext xrayIsExecutingMachineCode.
			  method } ] value: thisContext method'
			perform:with:with:)
		( '[:method|
			{ [:ctxt :msg :ign1| ctxt perform: msg] value: thisContext value: #pc value: nil.
			  thisContext xrayIsExecutingMachineCode.
			  method } ] value: thisContext method'
			value:value:value: ) ) do:
		[:case|
		 [:actualPc :executingMachineCode :method| | flag scanner expectedPc |
		  flag := false.
		  (scanner := InstructionStream on: method)
			scanFor:
				[:b| flag or: [flag := scanner selectorToSendOrSelf == case second. false]].
		  expectedPc := scanner pc.
		  self assert: actualPc = expectedPc.
		  self assert: executingMachineCode = runningOnCogit]
			valueWithArguments: (Compiler evaluate: case first logged: false)]