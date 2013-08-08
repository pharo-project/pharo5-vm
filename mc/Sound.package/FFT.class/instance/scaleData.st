transforming
scaleData
	"Scale all elements by 1/n when doing inverse"
	| realN |
	realN := n asFloat.
	1 to: n do:
		[:i |
		realData at: i put: (realData at: i) / realN.
		imagData at: i put: (imagData at: i) / realN]