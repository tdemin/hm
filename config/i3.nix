params: let
    dictKey = params.lib.dictKey;
    optionalElse = params.lib.optionalElse;
    optional = condition: then: optionalElse condition then "";
    machine = params.data.machine;
    wallpaper = dictKey params.data.i3 "wallpaper";
    usesDesktop = dictKey params.data.i3 "usesDesktop";
in ''
exec --no-startup-id xset -b
${optional (wallpaper != null) ''
exec --no-startup-id feh ${wallpaper}
''}
exec --no-startup-id conky -d
${optional (usesDesktop != null) ''
exec --no-startup-id ${usesDesktop}
''}

set $mod Mod4

focus_follows_mouse no
workspace_auto_back_and_forth yes
smart_borders on
hide_edge_borders vertical

exec --no-startup-id setxkbmap -layout us -option grp:caps_toggle,compose:rctrl
bindsym Caps_Lock exec --no-startup-id ~/.local/bin/ibus_switch.sh regular
bindsym $mod+F1 exec --no-startup-id ~/.local/bin/ibus_switch.sh targeted pc104 us xkb:us::eng
${optionalElse (machine == "haseul") ''
bindsym $mod+F2 exec --no-startup-id ~/.local/bin/ibus_switch.sh targeted pc105 jp mozc-jp
'' ''
bindsym $mod+F2 exec --no-startup-id ~/.local/bin/ibus_switch.sh targeted pc104 us mozc-jp
''}
bindsym $mod+F3 exec --no-startup-id ~/.local/bin/ibus_switch.sh targeted pc104 ru xkb:ru::rus
bindsym $mod+F4 exec --no-startup-id rofi -modi emoji -show emoji
bindsym $mod+F6 exec --no-startup-id ~/.local/bin/check_mail.sh

${optional (machine == "haseul") ''
for_window [instance="AlacrittyFloating"] floating enable
for_window [class="X-terminal-emulator"] floating enable
for_window [class="qBittorrent"] floating enable
for_window [class="Notable"] floating enable
for_window [class="nvim-qt"] floating enable, resize set 900 600, move position center
for_window [instance="AlacrittyNcmpcpp"] floating enable, resize set 1440 720, move position center
''}
${optional (machine == "yeojin") ''
for_window [class="iwgtk"] floating enable
''}
for_window [class="^explorer.exe$"] floating enable
for_window [instance="tagainijisho"] floating enable
for_window [class="KeePassXC"] floating enable
for_window [class="Virt-manager"] floating enable
for_window [class="Anki"] floating enable
for_window [class="Doublecmd"] floating enable, move position center
for_window [class="copyq"] floating enable
for_window [class="Pavucontrol"] floating enable
for_window [class="Lxtask"] floating enable
for_window [class="Image Lounge"] floating enable
for_window [class="kleopatra"] floating enable
for_window [class="qalculate-gtk"] floating enable
for_window [class="org.remmina.Remmina"] floating enable
for_window [class="gnome-disks"] floating enable
for_window [class="xarchiver"] floating enable
for_window [class="file-roller"] floating enable
for_window [window_role="pop-up"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [window_type="dialog"] floating enable
for_window [window_type="splash"] floating enable

${optionalElse (machine == "yeojin") ''
font pango:Arial 8
'' ''
font pango:Arial 10
''}
exec --no-startup-id picom
exec --no-startup-id dunst
exec --no-startup-id xss-lock --transfer-sleep-lock -- ~/.local/bin/i3lock.sh
exec --no-startup-id copyq
exec --no-startup-id keepassxc
exec --no-startup-id nextcloud
exec --no-startup-id redshift-qt
exec --no-startup-id mate-polkit
exec --no-startup-id pasystray
${optional (machine == "haseul") ''
exec --no-startup-id virt-manager
exec --no-startup-id qbittorrent
exec --no-startup-id kleopatra
exec --no-startup-id telegram-desktop
exec --no-startup-id ripcord
exec --no-startup-id dino
exec --no-startup-id element-desktop
''}
${optional (machine == "yeojin") ''
exec --no-startup-id nm-applet
exec --no-startup-id blueman-applet
''}
bindsym $mod+z exec --no-startup-id ~/.local/bin/ror.sh instance "AlacrittyFloating" "alacritty --class=AlacrittyFloating -e ~/.local/bin/start_tmux.sh -f" 11
bindsym $mod+Shift+Return exec --no-startup-id alacritty -e ~/.local/bin/start_tmux.sh
bindsym $mod+Return exec --no-startup-id alacritty
bindsym $mod+r exec rofi -show drun -show-icons
bindsym $mod+Shift+z exec --no-startup-id ~/.local/bin/tmux_picker.sh
bindsym $mod+l exec loginctl lock-session
bindsym $mod+e exec --no-startup-id ~/.local/bin/ror.sh class Doublecmd doublecmd 11
bindsym $mod+c exec --no-startup-id ~/.local/bin/ror.sh class nvim-qt nvim-qt 11
bindsym Print exec --no-startup-id ~/.local/bin/screenshot.sh --copy
bindsym Ctrl+Print exec --no-startup-id ~/.local/bin/screenshot.sh --region --copy
bindsym Mod1+Print exec --no-startup-id ~/.local/bin/screenshot.sh --window --copy
bindsym Mod1+Tab exec rofi -show window

set $refresh_i3status killall -SIGUSR1 i3status
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && $refresh_i3status
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && $refresh_i3status
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status
bindsym XF86MonBrightnessDown exec --no-startup-id xbacklight -dec 10
bindsym XF86MonBrightnessUp exec --no-startup-id xbacklight -inc 10
bindsym $mod+F11 exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && $refresh_i3status
bindsym $mod+F10 exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && $refresh_i3status
bindsym $mod+F9 exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
bindsym $mod+F8 exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status
bindsym $mod+F12 exec --no-startup-id ~/.local/bin/caffeine.sh
bindsym $mod+F5 exec --no-startup-id ~/.local/bin/dunst_toggle.sh
bindsym $mod+Mod1+p exec --no-startup-id mpc toggle
bindsym $mod+Mod1+n exec --no-startup-id mpc next
bindsym $mod+Mod1+b exec --no-startup-id mpc prev
bindsym $mod+m exec i3-input -F 'mark %s' -l 1 -P 'Mark: '
bindsym $mod+g exec i3-input -F '[con_mark="%s"] focus' -l 1 -P 'Goto: '

floating_modifier $mod

bindsym $mod+Shift+c reload
bindsym $mod+Shift+r restart
bindsym Mod1+F4 kill

bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

bindsym $mod+h split h
bindsym $mod+v split v
bindsym $mod+f fullscreen toggle
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+a layout toggle split
bindsym $mod+x floating toggle

bindsym $mod+Shift+d move scratchpad
bindsym $mod+d scratchpad show
bindsym $mod+space focus mode_toggle
bindsym $mod+Shift+a focus parent

set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"
set $ws6 "6"
set $ws7 "7"
set $ws8 "8"
set $ws9 "9"
set $ws10 "10"
bindsym $mod+1 workspace number $ws1
bindsym $mod+2 workspace number $ws2
bindsym $mod+3 workspace number $ws3
bindsym $mod+4 workspace number $ws4
bindsym $mod+5 workspace number $ws5
bindsym $mod+6 workspace number $ws6
bindsym $mod+7 workspace number $ws7
bindsym $mod+8 workspace number $ws8
bindsym $mod+9 workspace number $ws9
bindsym $mod+0 workspace number $ws10
bindsym $mod+Shift+1 move container to workspace number $ws1
bindsym $mod+Shift+2 move container to workspace number $ws2
bindsym $mod+Shift+3 move container to workspace number $ws3
bindsym $mod+Shift+4 move container to workspace number $ws4
bindsym $mod+Shift+5 move container to workspace number $ws5
bindsym $mod+Shift+6 move container to workspace number $ws6
bindsym $mod+Shift+7 move container to workspace number $ws7
bindsym $mod+Shift+8 move container to workspace number $ws8
bindsym $mod+Shift+9 move container to workspace number $ws9
bindsym $mod+Shift+0 move container to workspace number $ws10

mode "resize" {
    bindsym Left resize shrink width 20 px or 5 ppt
    bindsym Down resize grow height 20 px or 5 ppt
    bindsym Up resize shrink height 20 px or 5 ppt
    bindsym Right resize grow width 20 px or 5 ppt
    bindsym Return mode "default"
    bindsym Escape mode "default"
    bindsym $mod+t mode "default"
}
bindsym $mod+t mode "resize"

client.focused #81a2be #81a2be #1d1f21 #282a2e
client.focused_inactive #373b41 #373b41 #969896 #282a2e
client.unfocused #282a2e #282a2e #969896 #282a2e
client.urgent #373b41 #cc6666 #ffffff #cc6666

bar {
    status_command python ~/.local/bin/i3status.py
    ${optionalElse (machine == "yeojin") ''
    font pango:Fira Code 10
    '' ''
    font pango:Fira Code 9
    ''}
    colors {
        separator #969896
        background #1d1f21
        statusline #c5c8c6
        focused_workspace #81a2be #81a2be #1d1f21
        active_workspace #373b41 #373b41 #ffffff
        inactive_workspace #282a2e #282a2e #969896
        urgent_workspace #cc6666 #cc6666 #ffffff
    }
    workspace_buttons yes
}
''
