generating actions
copyLink: src to: dest
	"Makes a copy of a link, respecting the link condition (otherwise it will copy the destination file)"
	| str |
	
	str := 'add_custom_command( OUTPUT "{2}"
	COMMAND cp -d "{1}" "{2}"
	DEPENDS "{1}"
	)' format: {src. dest }.
	
	gen puts: str