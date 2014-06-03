transforms
primitiveInplaceHouseHolderInvert
	"Primitive. Perform an inplace house holder matrix inversion"
	| rcvr d x sigma beta sum s m |
	<export: true>
	<var: #rcvr declareC:'float *rcvr'>
	<var: #m declareC:'double m[4][4]'>
	<var: #x declareC:'double x[4][4] = { {1, 0, 0, 0}, {0, 1, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1} }'>
	<var: #d declareC:'double d[4][4]'>
	<var: #sigma declareC:'double sigma'>
	<var: #beta declareC:'double beta'>
	<var: #sum declareC:'double sum'>
	<var: #s declareC:'double s'>

	self cCode:'' inSmalltalk:[
		m := CArrayAccessor on: 
				((1 to: 4) collect:[:i| CArrayAccessor on: (Array new: 4)]).
		x := CArrayAccessor on: (Array
				with: (CArrayAccessor on: #(1.0 0.0 0.0 0.0) copy)
				with: (CArrayAccessor on: #(0.0 1.0 0.0 0.0) copy)
				with: (CArrayAccessor on: #(0.0 0.0 1.0 0.0) copy)
				with: (CArrayAccessor on: #(0.0 0.0 0.0 1.0) copy)).
		d := CArrayAccessor on: 
				((1 to: 4) collect:[:i| CArrayAccessor on: (Array new: 4)]).
	].
	rcvr := self stackMatrix: 0.
	0 to: 3 do:[:i| 0 to: 3 do:[:j|
		(m at: i) at: j put: (rcvr at: i*4+j)]].
	0 to: 3 do:[:j|
		sigma := 0.0.
		j to: 3 do:[:i| sigma := sigma + (((m at: i) at: j)  * ((m at: i) at: j))].
		sigma < 1.0e-10 ifTrue:[^interpreterProxy primitiveFail]. "matrix is singular"
		(((m at: j) at: j) < 0.0) 
			ifTrue:[ s:= sigma sqrt]
			ifFalse:[ s:= 0.0 - sigma sqrt].
		0 to: 3 do:[:r| (d at: j) at: r put: s].
		beta := 1.0 / ( s * ((m at: j) at: j) - sigma).
		(m at: j) at: j put: (((m at: j) at: j) - s).
		"update remaining columns"
		j+1 to: 3 do:[:k|
			sum := 0.0.
			j to: 3 do:[:i| sum := sum + (((m at: i) at: j) * ((m at: i) at: k))].
			sum := sum * beta.
			j to: 3 do:[:i| 
				(m at: i) at: k put: (((m at: i) at: k) + (((m at: i) at: j) * sum))]].
		"update vector"
		0 to: 3 do:[:r|
			sum := 0.0.
			j to: 3 do:[:i| 
				sum := sum + (((x at: i) at: r) * ((m at: i) at: j))].
			sum := sum * beta.
			j to: 3 do:[:i| 
				(x at: i) at: r put:(((x at: i) at: r) + (sum * ((m at: i) at: j)))].
		].
	].
	"Now calculate result"
	0 to: 3 do:[:r|
		3 to: 0 by: -1 do:[:i|
			i+1 to: 3 do:[:j|
				(x at: i) at: r put: (((x at: i) at: r) - (((x at: j) at: r) * ((m at: i) at: j))) ].
			(x at: i) at: r put: (((x at: i) at: r) / ((d at: i) at: r))].
	].
	0 to: 3 do:[:i| 0 to: 3 do:[:j|
		rcvr at: i*4+j put: (self cCoerce: ((x at: i) at: j) to:'float')]].
	"Return receiver"
	^nil