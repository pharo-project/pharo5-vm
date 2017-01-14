accessing edges
edgeTypeOf: edge
	"Return the edge type (e.g., witout the wide edge flag)"

	^(self objectTypeOf: edge) >> 1