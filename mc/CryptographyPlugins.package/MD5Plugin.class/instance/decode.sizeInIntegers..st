as yet unclassified
decode: array sizeInIntegers: n
	"Change the endianness of the first n integers in array. Used only on big endian platforms."
	
	| temp |
	<static: false>
	<inline: true>
	<var: #array type: #'char*'>
	<var: #n type: #'unsigned int'>
	<var: #i type: #'unsigned int'>
	<var: #temp type: #'unsigned int'>

	0 to: 4 * n - 1 by: 4 do: [ :i |
		temp := array at: i.
		array at: i put: (array at: i + 3).
		array at: i + 3 put: temp.
		temp := array at: i + 1.
		array at: i + 1 put: (array at: i + 2).
		array at: i + 2 put: temp ]