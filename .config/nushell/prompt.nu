def git_status [] {
    if ((which git | get command | str join) != git) { return }

    if (('.git' | path exists) == false) { return }

    let git_dir = (run-external "git" "rev-parse" "--git-dir")
    if (($git_dir | path exists) == false) { return }

    let git_branch = (run-external "git" "branch" "--show-current")
    let git_remote = (run-external "git" "for-each-ref" "--format='%(upstream:short)'" (run-external "git" "symbolic-ref" "-q" "HEAD") "origin/mainline")

    mut git_behind = 0
    mut git_ahead = 0
    if (($git_branch != "") and ($git_remote != "")) {
        $git_behind = ((run-external "git" "rev-list" "--count" $"($git_branch)..($git_remote)") | into int)
        $git_ahead = ((run-external "git" "rev-list" "--count" $"($git_remote)..($git_branch)") | into int)
    }

    let git_dirty = (run-external "git" "status" "-s") != ""
    let git_staged = (run-external "git" "diff" "--cached") != ""
    let git_stashed = (run-external "git" "stash" "list") != ""

    let clean_dirty_color = (if ($git_dirty) { (ansi { fg: "#ff7700" }) } else { (ansi green) })
    let behind_color = (ansi { fg: "#ff7700" })
    let ahead_color = (ansi yellow)
    let staged_color = (ansi { fg: "#bbffbb" })
    let stashed_color = (ansi { fg: "#ffcc00" })
    ([
        (ansi reset),
        (if ($git_branch != "") { $"($clean_dirty_color)(char space)""(char space)($git_branch)" }),
        (if ($git_branch == "") { $"($behind_color)(char space)⟡(char space)((run-external "git" "branch") | (run-external 'grep' '-oP' '(?<=\* \()[^)]+'))" }),
        (if ($git_behind > 0) { $"($behind_color)(char space)↓($git_behind)" }),
        (if ($git_ahead > 0) { $"($ahead_color)(char space)↑($git_ahead)" }),
        (if ($git_staged) { $"($staged_color)(char space)+" }),
        (if ($git_stashed) { $"($stashed_color)(char space)⋮" }),
    ] | str join)
}

export def create_left_prompt [] {
    let path_color = (ansi yellow)
    let separator_color = (ansi dark_gray)
    let user_color = (if (is-admin) { ansi red_bold } else { ansi yellow })
    let host_color = (ansi blue)

    let user_host = $"($user_color)($env.USER)(ansi reset)@($host_color)(sys | hostname)"

    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }
    let path_segment = $"($path_color)($dir)"
    let working_dir = $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"    

    $"($user_host)(char space)($working_dir)(git_status)"
}

export def create_right_prompt [] {
    let cmd_duration = ($"($env.CMD_DURATION_MS)ms" | into duration)
    ([
        (ansi dark_gray),
        (if $cmd_duration > 1min {"⌛"}),
        (if $cmd_duration > 1min {(ansi red)} else if $cmd_duration > 20sec {(ansi yellow)}),
        $cmd_duration,
        (if $env.LAST_EXIT_CODE != 0 {$"(ansi red) ⤫"})
    ] | str join)
}

# default to this if file is sourced:
export-env {
    $env.PROMPT_COMMAND = {|| create_left_prompt }
    $env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }
    $env.PROMPT_INDICATOR = {|| $"(ansi white) ⋟ " }
    # $env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
    # $env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
    # $env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }
}
