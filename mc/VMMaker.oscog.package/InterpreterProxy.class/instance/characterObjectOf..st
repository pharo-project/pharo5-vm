object access
characterObjectOf: characterCode
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	<var: #cPtr type: #int>
	^StackInterpreter objectMemoryClass characterObjectOf: characterCode