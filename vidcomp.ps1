# Compresses the video file $1 into $2, or $1_compressed if $2 is not specified, or every .mp4 file $x into compressed/$x if neither is specified
switch ($args.length) {
	3 { ffmpeg -i $args[0] -vcodec libx265 -crf (24 + $args[2]) $args[1] }
	2 { vidcomp $args[0] "$((Get-ChildItem $args[0])[0].BaseName)_compressed_$($args[1]).mp4" $args[1] }
	1 { vidcomp $args[0] 4 }
	0 {
		mkdir compressed -ErrorAction SilentlyContinue
		ForEach ($item in (Get-ChildItem -File -Path ./*.mp4).Name) {
			vidcomp $item "compressed/$item" 4
		}
	}
}
