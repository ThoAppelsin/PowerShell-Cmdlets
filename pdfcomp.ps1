# Compresses the .pdf file $1 into $2, or $1_compressed if $2 is not specified, or every .pdf file $x into compressed/$x if neither is specified
switch ($args.length) {
	2 { ps2pdf $args[0] $args[1] }
	1 { ps2pdf $args[0] "$($args[0])_compressed.pdf" }
	0 {
		mkdir compressed -ErrorAction SilentlyContinue
		ForEach ($item in (Get-ChildItem -File -Path ./*.pdf).Name) {
			pdfcomp $item "compressed/$item"
		}
	}
}
