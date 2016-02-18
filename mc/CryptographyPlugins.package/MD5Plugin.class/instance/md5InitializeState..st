as yet unclassified
md5InitializeState: state

	<static: false>
	<inline: true>
	<var: #state type: #'unsigned int*'>
	state at: 0 put: 16r67452301.
	state at: 1 put: 16rEFCDAB89.
	state at: 2 put: 16r98BADCFE.
	state at: 3 put: 16r10325476
