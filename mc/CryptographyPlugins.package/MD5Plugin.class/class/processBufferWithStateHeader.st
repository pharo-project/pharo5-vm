code generation
processBufferWithStateHeader

	^ 'md5ProcessBuffer: buffer withState: state
	"This method is generated. See #compileMethods on the class side."
	
	| a b c d |
	<static: false>
	<var: #buffer type: #''unsigned int*''>
	<var: #state type: #''unsigned int*''>
	<var: #a type: #''unsigned int''>
	<var: #b type: #''unsigned int''>
	<var: #c type: #''unsigned int''>
	<var: #d type: #''unsigned int''>
	a := state at: 0.
	b := state at: 1.
	c := state at: 2.
	d := state at: 3.'