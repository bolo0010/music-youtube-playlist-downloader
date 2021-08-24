@echo off
rem Script requires jq processor. Download it from: https://stedolan.github.io/jq/
rem Remember to set PATH to jq in system!

set playlist=LINK TO PLAYLIST
set destination="PATH TO SAVE FILES\%%(title)s.%%(ext)s"
set minimumDownloadLength=5

echo =========================================
echo Getting playlist length...
echo =========================================
youtube-dl %playlist% -J --flat-playlist | jq ".entries | length" > playlistLength.txt
set /p playlistLengthString=<playlistLength.txt
set /a playlistLength=%playlistLengthString%+0
del playlistLength.txt
echo Playlist length: %playlistLength%
echo =========================================
echo Downloading...
echo =========================================
if %playlistLength% GEQ %minimumDownloadLength% (
youtube-dl --download-archive "downloaded.txt" --add-metadata --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output %destination% --yes-playlist %playlist%
)
if %playlistLength% LSS %minimumDownloadLength% (
  echo Playlist has less than %minimumDownloadLength% length! Downloading aborted!
)
echo =========================================
echo Done
echo =========================================
pause
