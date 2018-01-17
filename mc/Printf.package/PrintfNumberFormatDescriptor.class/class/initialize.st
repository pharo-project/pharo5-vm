class initialization
initialize
	"PrintfNumberFormatDescriptor initialize"
	Base := Dictionary newFromPairs: #(	$d 10
											$o 8
											$p 16
											$u 10
											$x 16
											$X 16).

	Radix := Dictionary newFromPairs: #(	$d ''
											$o '0'
											$p '0x'
											$u ''
											$x '0x'
											$X '0X').

	Cased := 'AaEeFfGgXx'