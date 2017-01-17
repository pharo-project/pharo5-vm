transforming
incrementPoint: point by: delta
	<var: #point type:'int *'>
	point at: 0 put: (point at: 0) + delta.
	point at: 1 put: (point at: 1) + delta.