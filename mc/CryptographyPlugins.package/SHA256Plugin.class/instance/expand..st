private
expand: w

	| s0 s1 |
	self static: false.
	self inline: true.
	self var: #w type: #'unsigned int*'.
	self var: #s0 type: #'unsigned int'.
	self var: #s1 type: #'unsigned int'.
	self var: #i type: #'unsigned int'.
	16 to: 63 do: [ :i |
		s0 := (((w at: i - 15) >> 7) bitOr: ((w at: i - 15) << (32 - 7)))
			bitXor: (	(((w at: i - 15) >> 18) bitOr: ((w at: i - 15) << (32 - 18)))
			bitXor: ((w at: i - 15) >> 3)).
		s1 := (((w at: i - 2) >> 17) bitOr: ((w at: i - 2) << (32 - 17)))
			bitXor: ((((w at: i - 2) >> 19) bitOr: ((w at: i - 2) << (32 - 19)))
			bitXor: ((w at: i - 2) >> 10)).
		w at: i put: s0 + s1 + (w at: i - 16) + (w at: i - 7) ]