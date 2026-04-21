#!/usr/bin/env fish
# ✦ Gehenna — install.fish
# ──────────────────────────
# Symlinks all dotfiles into ~/.config.
# Safe to re-run — existing correct symlinks are skipped,
# existing real files are backed up before being replaced.

set repo   (path resolve (path dirname (status --current-filename)))
set cfg    $HOME/.config
set accent 7eb8d4
set dim    3a6080
set ok     5faf87
set warn   c8a86e

function _info
    set_color $accent; echo "  ✦ $argv"; set_color normal
end
function _skip
    set_color $dim;    echo "  · $argv"; set_color normal
end
function _ok
    set_color $ok;     echo "  ✓ $argv"; set_color normal
end
function _warn
    set_color $warn;   echo "  ! $argv"; set_color normal
end

function symlink
    set src $argv[1]
    set dst $argv[2]
    set label (string replace $HOME "~" $dst)

    set parent (path dirname $dst)
    if not test -d $parent
        mkdir -p $parent
        _info "mkdir "(string replace $HOME "~" $parent)
    end

    if test -L $dst
        if test (readlink $dst) = $src
            _skip "$label — already linked"
            return
        end
        rm $dst
    else if test -e $dst
        mv $dst $dst.bak
        _warn "backed up $label → $label.bak"
    end

    ln -s $src $dst
    _ok $label
end

echo
set_color $accent
echo "  ✦ Gehenna"
set_color $dim
echo "  ─────────────────────────────────────"
set_color normal
echo

_info "hyprland"
symlink $repo/hypr/hyprland.conf      $cfg/hypr/hyprland.conf
symlink $repo/hypr/hyprpaper.conf     $cfg/hypr/hyprpaper.conf
symlink $repo/hypr/monitors.conf      $cfg/hypr/monitors.conf

echo
_info "waybar"
symlink $repo/waybar/config.jsonc     $cfg/waybar/config.jsonc
symlink $repo/waybar/style.css        $cfg/waybar/style.css
symlink $repo/waybar/colors.css       $cfg/waybar/colors.css
symlink $repo/waybar/colors.css.templ $cfg/waybar/colors.css.templ
symlink $repo/waybar/dynamic-color.sh $cfg/waybar/dynamic-color.sh
symlink $repo/waybar/scripts/gpu.sh   $cfg/waybar/scripts/gpu.sh

echo
_info "kitty"
symlink $repo/kitty/kitty.conf        $cfg/kitty/kitty.conf

echo
_info "fish"
symlink $repo/fish/config.fish                  $cfg/fish/config.fish
symlink $repo/fish/functions/fish_greeting.fish $cfg/fish/functions/fish_greeting.fish

echo
_info "fastfetch"
symlink $repo/fastfetch/config.jsonc  $cfg/fastfetch/config.jsonc

echo
# Ensure shell scripts are executable
chmod +x $repo/waybar/dynamic-color.sh
chmod +x $repo/waybar/scripts/gpu.sh

set_color $accent
echo "  ✦ done."
set_color normal
echo
