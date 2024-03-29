function fish_prompt
    if [ -z $VIRTUAL_ENV ]
      printf '%s@%s%s[%s]%s$ ' (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (pwd) (set_color normal)
    else
      printf '%s(%s)%s %s@%s%s[%s]%s$ ' (set_color -b blue white) (basename "$VIRTUAL_ENV") (set_color normal) (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (pwd) (set_color normal)
    end
end

function workon -d "Activate virtual environment in $WORKON_HOME"
  set tgt {$WORKON_HOME}$argv[1]
  if [ -d $tgt ]
    #cd $tgt

    deactivate

    set -gx VIRTUAL_ENV "$tgt"
    set -gx _OLD_VIRTUAL_PATH $PATH
    set -gx PATH "$VIRTUAL_ENV/bin" $PATH

    # unset PYTHONHOME if set
    if set -q PYTHONHOME
       set -gx _OLD_VIRTUAL_PYTHONHOME $PYTHONHOME
       set -e PYTHONHOME
    end
  else
    echo "$tgt not found"
  end
end

complete -c workon -a "(cd $WORKON_HOME; ls -d *)"

function deactivate -d "Exit virtualenv and return to normal shell environment"
    # reset old environment variables
    if test -n "$_OLD_VIRTUAL_PATH"
        set -gx PATH $_OLD_VIRTUAL_PATH
        set -e _OLD_VIRTUAL_PATH
    end
    if test -n "$_OLD_VIRTUAL_PYTHONHOME"
        set -gx PYTHONHOME $_OLD_VIRTUAL_PYTHONHOME
        set -e _OLD_VIRTUAL_PYTHONHOME
    end
    set -e VIRTUAL_ENV
end
