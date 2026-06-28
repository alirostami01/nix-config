{ config, pkgs, ... }: {

  ## ── Kitty Terminal ─────────────────────────────────────────────────
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraMono Nerd Font";
      size = 12.0;
    };
    settings = {
      copy_on_select = true;
      shell_integration = "no-title";
      hide_window_decorations = true;
    };
  };

  ## ── Zellij (Terminal Multiplexer) ──────────────────────────────────
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
  };

  xdg.configFile."zellij/config.kdl".text = ''
    keybinds clear-defaults=true {
        locked {
            bind "Ctrl g" { SwitchToMode "normal"; }
        }
        pane {
            bind "left" { MoveFocus "left"; }
            bind "down" { MoveFocus "down"; }
            bind "up" { MoveFocus "up"; }
            bind "right" { MoveFocus "right"; }
            bind "c" { SwitchToMode "renamepane"; PaneNameInput 0; }
            bind "d" { NewPane "down"; SwitchToMode "normal"; }
            bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "normal"; }
            bind "f" { ToggleFocusFullscreen; SwitchToMode "normal"; }
            bind "h" { MoveFocus "left"; }
            bind "i" { TogglePanePinned; SwitchToMode "normal"; }
            bind "j" { MoveFocus "down"; }
            bind "k" { MoveFocus "up"; }
            bind "l" { MoveFocus "right"; }
            bind "n" { NewPane; SwitchToMode "normal"; }
            bind "p" { SwitchFocus; }
            bind "Ctrl p" { SwitchToMode "normal"; }
            bind "r" { NewPane "right"; SwitchToMode "normal"; }
            bind "s" { NewPane "stacked"; SwitchToMode "normal"; }
            bind "w" { ToggleFloatingPanes; SwitchToMode "normal"; }
            bind "z" { TogglePaneFrames; SwitchToMode "normal"; }
        }
        tab {
            bind "left" { GoToPreviousTab; }
            bind "down" { GoToNextTab; }
            bind "up" { GoToPreviousTab; }
            bind "right" { GoToNextTab; }
            bind "1" { GoToTab 1; SwitchToMode "normal"; }
            bind "2" { GoToTab 2; SwitchToMode "normal"; }
            bind "3" { GoToTab 3; SwitchToMode "normal"; }
            bind "4" { GoToTab 4; SwitchToMode "normal"; }
            bind "5" { GoToTab 5; SwitchToMode "normal"; }
            bind "6" { GoToTab 6; SwitchToMode "normal"; }
            bind "7" { GoToTab 7; SwitchToMode "normal"; }
            bind "8" { GoToTab 8; SwitchToMode "normal"; }
            bind "9" { GoToTab 9; SwitchToMode "normal"; }
            bind "[" { BreakPaneLeft; SwitchToMode "normal"; }
            bind "]" { BreakPaneRight; SwitchToMode "normal"; }
            bind "b" { BreakPane; SwitchToMode "normal"; }
            bind "h" { GoToPreviousTab; }
            bind "j" { GoToNextTab; }
            bind "k" { GoToPreviousTab; }
            bind "l" { GoToNextTab; }
            bind "n" { NewTab; SwitchToMode "normal"; }
            bind "r" { SwitchToMode "renametab"; TabNameInput 0; }
            bind "s" { ToggleActiveSyncTab; SwitchToMode "normal"; }
            bind "Ctrl t" { SwitchToMode "normal"; }
            bind "x" { CloseTab; SwitchToMode "normal"; }
            bind "tab" { ToggleTab; }
        }
        resize {
            bind "left" { Resize "Increase left"; }
            bind "down" { Resize "Increase down"; }
            bind "up" { Resize "Increase up"; }
            bind "right" { Resize "Increase right"; }
            bind "+" { Resize "Increase"; }
            bind "-" { Resize "Decrease"; }
            bind "=" { Resize "Increase"; }
            bind "H" { Resize "Decrease left"; }
            bind "J" { Resize "Decrease down"; }
            bind "K" { Resize "Decrease up"; }
            bind "L" { Resize "Decrease right"; }
            bind "h" { Resize "Increase left"; }
            bind "j" { Resize "Increase down"; }
            bind "k" { Resize "Increase up"; }
            bind "l" { Resize "Increase right"; }
            bind "Ctrl n" { SwitchToMode "normal"; }
        }
        move {
            bind "left" { MovePane "left"; }
            bind "down" { MovePane "down"; }
            bind "up" { MovePane "up"; }
            bind "right" { MovePane "right"; }
            bind "h" { MovePane "left"; }
            bind "Ctrl h" { SwitchToMode "normal"; }
            bind "j" { MovePane "down"; }
            bind "k" { MovePane "up"; }
            bind "l" { MovePane "right"; }
            bind "n" { MovePane; }
            bind "p" { MovePaneBackwards; }
            bind "tab" { MovePane; }
        }
        scroll {
            bind "e" { EditScrollback; SwitchToMode "normal"; }
            bind "s" { SwitchToMode "entersearch"; SearchInput 0; }
        }
        search {
            bind "c" { SearchToggleOption "CaseSensitivity"; }
            bind "n" { Search "down"; }
            bind "o" { SearchToggleOption "WholeWord"; }
            bind "p" { Search "up"; }
            bind "w" { SearchToggleOption "Wrap"; }
        }
        session {
            bind "a" { LaunchOrFocusPlugin "zellij:about" { floating true move_to_focused_tab true } SwitchToMode "normal"; }
            bind "c" { LaunchOrFocusPlugin "configuration" { floating true move_to_focused_tab true } SwitchToMode "normal"; }
            bind "l" { LaunchOrFocusPlugin "zellij:layout-manager" { floating true move_to_focused_tab true } SwitchToMode "normal"; }
            bind "Ctrl o" { SwitchToMode "normal"; }
            bind "p" { LaunchOrFocusPlugin "plugin-manager" { floating true move_to_focused_tab true } SwitchToMode "normal"; }
            bind "s" { LaunchOrFocusPlugin "zellij:share" { floating true move_to_focused_tab true } SwitchToMode "normal"; }
            bind "w" { LaunchOrFocusPlugin "session-manager" { floating true move_to_focused_tab true } SwitchToMode "normal"; }
        }
        shared_except "locked" {
            bind "Alt left" { MoveFocusOrTab "left"; }
            bind "Alt down" { MoveFocus "down"; }
            bind "Alt up" { MoveFocus "up"; }
            bind "Alt right" { MoveFocusOrTab "right"; }
            bind "Alt +" { Resize "Increase"; }
            bind "Alt -" { Resize "Decrease"; }
            bind "Alt f" { ToggleFloatingPanes; }
            bind "Ctrl g" { SwitchToMode "locked"; }
            bind "Alt h" { MoveFocusOrTab "left"; }
            bind "Alt i" { MoveTab "left"; }
            bind "Alt j" { MoveFocus "down"; }
            bind "Alt k" { MoveFocus "up"; }
            bind "Alt l" { MoveFocusOrTab "right"; }
            bind "Alt n" { NewPane; }
            bind "Alt o" { MoveTab "right"; }
            bind "Alt p" { TogglePaneInGroup; }
            bind "Alt Shift p" { ToggleGroupMarking; }
            bind "Ctrl q" { Quit; }
        }
        shared_except "locked" "move" { bind "Ctrl h" { SwitchToMode "move"; } }
        shared_except "locked" "session" { bind "Ctrl o" { SwitchToMode "session"; } }
        shared_except "locked" "scroll" "search" "tmux" { bind "Ctrl b" { SwitchToMode "tmux"; } }
        shared_except "locked" "scroll" "search" { bind "Ctrl s" { SwitchToMode "scroll"; } }
        shared_except "locked" "tab" { bind "Ctrl t" { SwitchToMode "tab"; } }
        shared_except "locked" "pane" { bind "Ctrl p" { SwitchToMode "pane"; } }
        shared_except "locked" "resize" { bind "Ctrl n" { SwitchToMode "resize"; } }
        shared_except "normal" "locked" "entersearch" { bind "enter" { SwitchToMode "normal"; } }
        shared_except "normal" "locked" "entersearch" "renametab" "renamepane" { bind "esc" { SwitchToMode "normal"; } }
        shared_among "pane" "tmux" { bind "x" { CloseFocus; SwitchToMode "normal"; } }
        shared_among "scroll" "search" {
            bind "PageDown" { PageScrollDown; }
            bind "PageUp" { PageScrollUp; }
            bind "left" { PageScrollUp; }
            bind "down" { ScrollDown; }
            bind "up" { ScrollUp; }
            bind "right" { PageScrollDown; }
            bind "Ctrl b" { PageScrollUp; }
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "normal"; }
            bind "d" { HalfPageScrollDown; }
            bind "Ctrl f" { PageScrollDown; }
            bind "h" { PageScrollUp; }
            bind "j" { ScrollDown; }
            bind "k" { ScrollUp; }
            bind "l" { PageScrollDown; }
            bind "Ctrl s" { SwitchToMode "normal"; }
            bind "u" { HalfPageScrollUp; }
        }
        entersearch {
            bind "Ctrl c" { SwitchToMode "scroll"; }
            bind "esc" { SwitchToMode "scroll"; }
            bind "enter" { SwitchToMode "search"; }
        }
        renametab {
            bind "esc" { UndoRenameTab; SwitchToMode "tab"; }
        }
        shared_among "renametab" "renamepane" { bind "Ctrl c" { SwitchToMode "normal"; } }
        renamepane { bind "esc" { UndoRenamePane; SwitchToMode "pane"; } }
        shared_among "session" "tmux" { bind "d" { Detach; } }
        tmux {
            bind "left" { MoveFocus "left"; SwitchToMode "normal"; }
            bind "down" { MoveFocus "down"; SwitchToMode "normal"; }
            bind "up" { MoveFocus "up"; SwitchToMode "normal"; }
            bind "right" { MoveFocus "right"; SwitchToMode "normal"; }
            bind "space" { NextSwapLayout; }
            bind '"' { NewPane "down"; SwitchToMode "normal"; }
            bind "%" { NewPane "right"; SwitchToMode "normal"; }
            bind "," { SwitchToMode "renametab"; }
            bind "[" { SwitchToMode "scroll"; }
            bind "Ctrl b" { Write 2; SwitchToMode "normal"; }
            bind "c" { NewTab; SwitchToMode "normal"; }
            bind "h" { MoveFocus "left"; SwitchToMode "normal"; }
            bind "j" { MoveFocus "down"; SwitchToMode "normal"; }
            bind "k" { MoveFocus "up"; SwitchToMode "normal"; }
            bind "l" { MoveFocus "right"; SwitchToMode "normal"; }
            bind "n" { GoToNextTab; SwitchToMode "normal"; }
            bind "o" { FocusNextPane; }
            bind "p" { GoToPreviousTab; SwitchToMode "normal"; }
            bind "z" { ToggleFocusFullscreen; SwitchToMode "normal"; }
        }
    }
    plugins {
        about location="zellij:about"
        compact-bar location="zellij:compact-bar"
        configuration location="zellij:configuration"
        filepicker location="zellij:strider" { cwd "/" }
        plugin-manager location="zellij:plugin-manager"
        session-manager location="zellij:session-manager"
        status-bar location="zellij:status-bar"
        strider location="zellij:strider"
        tab-bar location="zellij:tab-bar"
        welcome-screen location="zellij:session-manager" { welcome_screen true }
    }
    load_plugins {
        zellij:link
    }
    default_layout "clean"
    pane_frames false
    show_startup_tips false
  '';

  xdg.configFile."zellij/layouts".source = ../config/zellij/layouts;

  ## ── Yazi (Terminal File Manager) ──────────────────────────────────
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    settings = {
      opener = {
        edit = [
          { run = "nvim \"$@\""; block = true; desc = "Neovim"; }
        ];
      };
      open = {
        prepend_rules = [
          { mime = "text/*"; use = "edit"; }
          { mime = "application/json"; use = "edit"; }
          { mime = "inode/x-empty"; use = "edit"; }
        ];
      };
    };
  };

  xdg.configFile."yazi/keymap.toml".text = ''
    [[manager.prepend_keymap]]
    on   = [ "<C-f>" ]
    run  = "plugin fg -- fzf"
    desc = "Find file by filename"

    [[manager.prepend_keymap]]
    on   = [ "s", "g" ]
    run  = "plugin fg"
    desc = "Find file by content (fuzzy match)"

    [[manager.prepend_keymap]]
    on   = [ "s", "G" ]
    run  = "plugin fg -- rg"
    desc = "Find file by content (ripgrep match)"
  '';

  ## ── Tilda (Dropdown Terminal) ─────────────────────────────────────
  xdg.configFile."tilda/config_0".text = ''
    tilda_config_version="1.5.4"
    command=""
    font="Monospace 11"
    key="F1"
    addtab_key="<Shift><Control>t"
    fullscreen_key="F11"
    toggle_transparency_key="F12"
    toggle_searchbar_key="<Shift><Control>f"
    closetab_key="<Shift><Control>w"
    nexttab_key="<Control>Page_Down"
    prevtab_key="<Control>Page_Up"
    movetableft_key="<Shift><Control>Page_Up"
    movetabright_key="<Shift><Control>Page_Down"
    gototab_1_key="<Alt>1"
    gototab_2_key="<Alt>2"
    gototab_3_key="<Alt>3"
    gototab_4_key="<Alt>4"
    gototab_5_key="<Alt>5"
    gototab_6_key="<Alt>6"
    gototab_7_key="<Alt>7"
    gototab_8_key="<Alt>8"
    gototab_9_key="<Alt>9"
    gototab_10_key="<Alt>0"
    copy_key="<Shift><Control>c"
    paste_key="<Shift><Control>v"
    quit_key="<Shift><Control>q"
    title="Tilda"
    background_color="white"
    web_browser="xdg-open"
    increase_font_size_key="<Control>equal"
    decrease_font_size_key="<Control>minus"
    normalize_font_size_key="<Control>0"
    show_on_monitor=""
    word_chars="-A-Za-z0-9,./?%&#:_"
    lines=5000
    x_pos=0
    y_pos=33
    tab_pos=0
    expand_tabs=false
    show_single_tab=false
    backspace_key=0
    delete_key=1
    d_set_title=3
    command_exit=2
    command_timeout_ms=3000
    scheme=3
    slide_sleep_usec=20131
    animation_orientation=3
    timer_resolution=200
    auto_hide_time=2000
    on_last_terminal_exit=0
    prompt_on_exit=true
    palette_scheme=1
    non_focus_pull_up_behaviour=0
    cursor_shape=0
    title_max_length=25
    scrollbar_pos=2
    back_red=0
    back_green=0
    back_blue=0
    text_red=65535
    text_green=65535
    text_blue=65535
    cursor_red=65535
    cursor_green=65535
    cursor_blue=65535
    width_percentage=2147483647
    height_percentage=2147483647
    scroll_history_infinite=false
    scroll_on_output=false
    notebook_border=true
    scrollbar=false
    grab_focus=true
    above=true
    notaskbar=true
    blinks=true
    scroll_on_key=true
    bell=false
    run_command=false
    pinned=true
    animation=true
    hidden=false
    set_as_desktop=false
    centered_horizontally=false
    centered_vertically=false
    enable_transparency=true
    auto_hide_on_focus_lost=false
    auto_hide_on_mouse_leave=false
    title_behaviour=2
    inherit_working_dir=true
    command_login_shell=false
    start_fullscreen=false
    confirm_close_tab=true
    back_alpha=55705
    show_title_tooltip=false
  '';

  xdg.configFile."tilda/config_1".text = ''
    tilda_config_version="1.5.4"
    command=""
    font="Monospace 11"
    key="F2"
    addtab_key="<Shift><Control>t"
    fullscreen_key="F11"
    toggle_transparency_key="F12"
    toggle_searchbar_key="<Shift><Control>f"
    closetab_key="<Shift><Control>w"
    nexttab_key="<Control>Page_Down"
    prevtab_key="<Control>Page_Up"
    movetableft_key="<Shift><Control>Page_Up"
    movetabright_key="<Shift><Control>Page_Down"
    gototab_1_key="<Alt>1"
    gototab_2_key="<Alt>2"
    gototab_3_key="<Alt>3"
    gototab_4_key="<Alt>4"
    gototab_5_key="<Alt>5"
    gototab_6_key="<Alt>6"
    gototab_7_key="<Alt>7"
    gototab_8_key="<Alt>8"
    gototab_9_key="<Alt>9"
    gototab_10_key="<Alt>0"
    copy_key="<Shift><Control>c"
    paste_key="<Shift><Control>v"
    quit_key="<Shift><Control>q"
    title="Tilda"
    background_color="white"
    web_browser="xdg-open"
    increase_font_size_key="<Control>equal"
    decrease_font_size_key="<Control>minus"
    normalize_font_size_key="<Control>0"
    show_on_monitor=""
    word_chars="-A-Za-z0-9,./?%&#:_"
    lines=5000
    x_pos=0
    y_pos=27
    tab_pos=0
    expand_tabs=false
    show_single_tab=false
    backspace_key=0
    delete_key=1
    d_set_title=3
    command_exit=2
    command_timeout_ms=3000
    scheme=3
    slide_sleep_usec=20000
    animation_orientation=0
    timer_resolution=200
    auto_hide_time=2000
    on_last_terminal_exit=0
    prompt_on_exit=true
    palette_scheme=1
    non_focus_pull_up_behaviour=0
    cursor_shape=0
    title_max_length=25
    scrollbar_pos=2
    back_red=0
    back_green=0
    back_blue=0
    text_red=65535
    text_green=65535
    text_blue=65535
    cursor_red=65535
    cursor_green=65535
    cursor_blue=65535
    width_percentage=2147483647
    height_percentage=2147483647
    scroll_history_infinite=false
    scroll_on_output=false
    notebook_border=false
    scrollbar=false
    grab_focus=true
    above=true
    notaskbar=true
    blinks=true
    scroll_on_key=true
    bell=false
    run_command=false
    pinned=true
    animation=false
    hidden=false
    set_as_desktop=false
    centered_horizontally=false
    centered_vertically=false
    enable_transparency=false
    auto_hide_on_focus_lost=false
    auto_hide_on_mouse_leave=false
    title_behaviour=2
    inherit_working_dir=true
    command_login_shell=false
    start_fullscreen=false
    confirm_close_tab=true
    back_alpha=65535
    show_title_tooltip=false
  '';

  ## ── btop (System Monitor) ─────────────────────────────────────────
  xdg.configFile."btop/btop.conf".text = ''
    color_theme = "Default"
    theme_background = True
    truecolor = True
    force_tty = False
    presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty"
    vim_keys = False
    rounded_corners = True
    graph_symbol = "braille"
    graph_symbol_cpu = "default"
    graph_symbol_mem = "default"
    graph_symbol_net = "default"
    graph_symbol_proc = "default"
    shown_boxes = "cpu mem net proc"
    update_ms = 2000
    proc_sorting = "cpu lazy"
    proc_reversed = False
    proc_tree = False
    proc_colors = True
    proc_gradient = True
    proc_per_core = False
    proc_mem_bytes = True
    proc_info_smaps = False
    proc_left = False
    cpu_graph_upper = "total"
    cpu_graph_lower = "total"
    cpu_invert_lower = True
    cpu_single_graph = False
    cpu_bottom = False
    show_uptime = True
    check_temp = True
    cpu_sensor = "Auto"
    show_coretemp = True
    cpu_core_map = ""
    temp_scale = "celsius"
    base_10_sizes = False
    show_cpu_freq = True
    clock_format = "%X"
    background_update = True
    custom_cpu_name = ""
    disks_filter = ""
    mem_graphs = True
    mem_below_net = False
    show_swap = True
    swap_disk = True
    show_disks = True
    only_physical = True
    use_fstab = True
    disk_free_priv = False
    show_io_stat = True
    io_mode = False
    io_graph_combined = False
    io_graph_speeds = ""
    net_download = 100
    net_upload = 100
    net_auto = True
    net_sync = False
    net_iface = ""
    show_battery = True
    selected_battery = "Auto"
    log_level = "WARNING"
  '';

  ## ── htop (Process Viewer) ─────────────────────────────────────────
  xdg.configFile."htop/htoprc".text = ''
    fields=0 48 17 18 38 39 40 2 46 47 49 1
    sort_key=46
    sort_direction=-1
    tree_sort_key=0
    tree_sort_direction=1
    hide_kernel_threads=1
    hide_userland_threads=0
    shadow_other_users=0
    show_thread_names=0
    show_program_path=1
    highlight_base_name=0
    highlight_megabytes=1
    highlight_threads=1
    highlight_changes=0
    highlight_changes_delay_secs=5
    find_comm_in_cmdline=1
    strip_exe_from_cmdline=1
    show_merged_command=0
    tree_view=1
    tree_view_always_by_pid=0
    header_margin=1
    detailed_cpu_time=0
    cpu_count_from_one=0
    show_cpu_usage=1
    show_cpu_frequency=0
    show_cpu_temperature=0
    degree_fahrenheit=0
    update_process_names=0
    account_guest_in_cpu_meter=0
    color_scheme=0
    enable_mouse=1
    delay=15
    left_meters=AllCPUs Memory Swap
    left_meter_modes=1 1 1
    right_meters=Tasks LoadAverage Uptime
    right_meter_modes=2 2 2
    hide_function_bar=0
  '';
}
