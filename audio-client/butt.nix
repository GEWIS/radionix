{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [ ];

  sops.secrets."icecast/source_password" = { };

  sops.templates.".buttrc".content = ''
    #This is a configuration file for butt (broadcast using this tool)

    [main]
    bg_color = 252645120
    txt_color = -256
    server = GEWIS Icecast
    srv_ent = GEWIS Icecast
    icy = 
    icy_ent = 
    num_of_srv = 1
    num_of_icy = 0
    song_update_url_active = 0
    song_update_url_interval = 1
    song_update_url =
    song_path = 
    song_update = 0
    song_delay = 0
    song_prefix = 
    song_suffix = 
    read_last_line = 0
    app_update_service = 3
    app_update = 1
    app_artist_title_order = 1
    gain = 1.000000
    signal_threshold = 0.000000
    silence_threshold = 0.000000
    signal_detection = 0
    silence_detection = 0
    check_for_update = 1
    start_agent = 0
    minimize_to_tray = 0
    connect_at_startup = 0
    force_reconnecting = 0
    reconnect_delay = 1
    ic_charset = 
    log_file = 

    [audio]
    device = 9
    device2 = -1
    dev_remember = 1
    samplerate = 48000
    bitrate = 128
    channel = 2
    left_ch = 1
    right_ch = 2
    left_ch2 = 1
    right_ch2 = 2
    codec = mp3
    resample_mode = 1
    silence_level = 50.000000
    signal_level = 50.000000
    disable_dithering = 0
    buffer_ms = 50
    dev_name = Single interface input [JACK Audio Connection Kit]
    dev2_name = None

    [record]
    bitrate = 192
    codec = mp3
    start_rec = 0
    stop_rec = 0
    rec_after_launch = 0
    overwrite_files = 0
    sync_to_hour  = 0
    split_time = 0
    filename = rec_%Y%m%d-%H%M%S.mp3
    signal_threshold = 0.000000
    silence_threshold = 0.000000
    signal_detection = 0
    silence_detection = 0
    folder = /home/radio/

    [tls]
    cert_file = 
    cert_dir = 

    [dsp]
    equalizer = 0
    equalizer_rec = 0
    eq_preset = Manual
    gain1 = 0.000000
    gain2 = 0.000000
    gain3 = 0.000000
    gain4 = 0.000000
    gain5 = 0.000000
    gain6 = 0.000000
    gain7 = 0.000000
    gain8 = 0.000000
    gain9 = 0.000000
    gain10 = 0.000000
    compressor = 0
    compressor_rec = 0
    aggressive_mode = 0
    threshold = -20.000000
    ratio = 5.000000
    attack = 0.010000
    release = 1.000000
    makeup_gain = 0.000000

    [mixer]
    primary_device_gain = 1.000000
    primary_device_muted = 0
    secondary_device_gain = 1.000000
    secondary_device_muted = 0
    streaming_gain = 1.000000
    recording_gain = 1.000000
    cross_fader = 0.000000

    [gui]
    attach = 0
    ontop = 0
    hide_log_window = 0
    remember_pos = 1
    x_pos = 1393
    y_pos = 243
    window_height = 395
    lcd_auto = 0
    default_stream_info = 0
    start_minimized = 0
    disable_gain_slider = 0
    show_listeners = 1
    listeners_update_rate = 10
    lang_str = system
    vu_low_color = 13762560
    vu_mid_color = -421134336
    vu_high_color = -939524096
    vu_mid_range_start = -12
    vu_high_range_start = -6
    always_show_vu_tabs = 1
    window_title = 
    vu_mode = 1

    [mp3_codec_stream]
    enc_quality = 3
    stereo_mode = 0
    bitrate_mode = 0
    vbr_quality = 4
    vbr_min_bitrate = 32
    vbr_max_bitrate = 320
    vbr_force_min_bitrate = 0
    resampling_freq = 0
    lowpass_freq_active = 0
    lowpass_freq = 0.000000
    lowpass_width_active = 0
    lowpass_width = 0.000000
    highpass_freq_active = 0
    highpass_freq = 0.000000
    highpass_width_active = 0
    highpass_width = 0.000000

    [GEWIS Icecast]
    address = radio-icecast.gewis.nl
    port = 8000
    password = ${config.sops.placeholder."icecast/source_password"}
    type = 1
    tls = 0
    custom_listener_url = 
    custom_listener_mount = 
    cert_hash = 
    mount = stream
    usr = source
    protocol = 0
  '';

  sops.templates.".buttrc".path = "/etc/.buttrc";
  sops.templates.".buttrc".owner = "radio";
}
