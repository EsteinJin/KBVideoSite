<div id="screen">
<!--[if IE]>
<object type="application/x-vlc-plugin" pluginspage="http://www.videolan.org"
    version="VideoLAN.VLCPlugin.2" id="vlc" width="720px"
    height="540px" events="True" classid="clsid:9BE31822-FDAD-461B-AD51-BE1D1C159921" >
    <param name="MRL" value="video.ext" />
    <param name="volume" value="50" />
    <param name="autoplay" value="false" />
    <param name="loop" value="false" />
    <param name="fullscreen" value="false" />
</object>
<![endif]-->

<!--[if !IE]><!-->
<object type="application/x-vlc-plugin" pluginspage="http://www.videolan.org"
    version="VideoLAN.VLCPlugin.2" id="vlc" width="720px" height="540px" events="True" >
    <param name="MRL" value="video.ext" />
    <param name="volume" value="50" />
    <param name="autoplay" value="false" />
    <param name="loop" value="false" />
    <param name="fullscreen" value="false" />
</object>
<!--<![endif]-->
</div>

<script type="text/javascript">
function mute()
    {
    vlc.audio.toggleMute();
    }
function play()
    {
    vlc.playlist.play();
    }
function stop()
    {
    vlc.playlist.stop();
    }
function pause()
    {  
    vlc.playlist.togglePause();
    }
</script>
<br />
</div>

<div id="controls">
    <input type="button" onclick="play()" value="Play" />
    <input type="button" onclick="pause()" value="Pause" />
    <input type="button" onclick="stop()" value="Stop" />
    <input type="button" onclick="mute()" value="Mute" />
</div>
