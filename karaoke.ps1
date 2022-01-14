spleet

$sourceaudiopattern = "*-$($args[0]).*" 
$outdir = "output"

if (!(Test-Path $sourceaudiopattern -PathType Leaf)) {
	youtube-dl --extract-audio $args[0] # --audio-format might be useful later on
}
$sourceaudio = (Get-Item $sourceaudiopattern)[0]

$spleetdir = "$outdir/$($sourceaudio.BaseName)"
$vocals = "$spleetdir/vocals.wav"
$accompaniment = "$spleetdir/accompaniment.wav"

if (!(Test-Path $vocals -PathType Leaf) -or !(Test-Path $accompaniment -PathType Leaf)) {
	spleeter separate -o "$outdir/" "$sourceaudio"
}

if ($args.length -gt 1) {
	$mix = "$spleetdir/mix_$($args[1]).wav"

	if (!(Test-Path $mix -PathType Leaf)) {
		ffmpeg -i "$vocals" -i "$accompaniment" -filter_complex "[0]volume=0.$($args[1])[s1];[1]volume=1[s2];[s1][s2]amix[a]" -map [a] "$mix"
	}
}

ex "$spleetdir"
