switch ($args.length) {
	2 { ps2pdf $args[0] $args[1] }
	1 { ps2pdf $args[0] "$($args[0])_compressed.pdf" }
	0 {
		mkdir compressed -ErrorAction SilentlyContinue
		ForEach ($item in (Get-ChildItem -File -Path .).Name) {
			pdfcomp $item "compressed/$item"
		}
	}
}
