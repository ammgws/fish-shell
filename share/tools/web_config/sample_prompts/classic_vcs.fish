# name: Classic + Vcs
# author: Lily Ballard

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l last_status $status
    set -l normal (set_color normal)

    # Initialize our variables.
    set -q fish_color_user
    or set -U fish_color_user -o green
    set -q fish_color_host
    or set -U fish_color_host -o cyan
    set -q fish_color_status
    or set -U fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l prefix
    set -l suffix '>'
    if contains -- $USER root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            end
            set suffix '#'
    end

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus "[" "] " "|" (set_color yellow) (set_color --bold yellow) $last_pipestatus)
    if test $last_status -ne 0
        set prompt_status " $prompt_status" (set_color $fish_color_status) "[$last_status]" "$normal"
    end

    echo -n -s (set_color $fish_color_user) "$USER" $normal @ (set_color $fish_color_host) (prompt_hostname) $normal ' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal $prompt_status $suffix " "
end
