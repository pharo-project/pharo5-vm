generating actions
copy: src to: dest

	| str |

	
	str := 'add_custom_command( OUTPUT "{2}"
	COMMAND cp "{1}" "{2}"
	DEPENDS "{1}"
	)' format: {src. dest }.
	
	gen puts: str