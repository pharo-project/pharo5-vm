private
sha256InitializeState: state
	"#(2 3 5 7 11 13 17 19) collect: [:x | (x asFloat sqrt fractionPart * (2 raisedTo: 32)) truncated storeStringHex ]"

	self static: false.
	self inline: true.
	self var: #state type: #'unsigned int*'.
	state at: 0 put: 16r6A09E667.
	state at: 1 put: 16rBB67AE85.
	state at: 2 put: 16r3C6EF372.
	state at: 3 put: 16rA54FF53A.
	state at: 4 put: 16r510E527F.
	state at: 5 put: 16r9B05688C.
	state at: 6 put: 16r1F83D9AB.
	state at: 7 put: 16r5BE0CD19

