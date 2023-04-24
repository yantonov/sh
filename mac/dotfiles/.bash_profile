# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# Load my settings
[[ -s "$HOME/.config/shell_profile/.colors" ]]       && source "$HOME/.config/shell_profile/.colors"
[[ -s "$HOME/.config/shell_profile/.path" ]]         && source "$HOME/.config/shell_profile/.path"
[[ -s "$HOME/.config/shell_profile/.alias_common" ]] && source "$HOME/.config/shell_profile/.alias_common"
[[ -s "$HOME/.config/shell_profile/.pyenv" ]]        && source "$HOME/.config/shell_profile/.pyenv"
[[ -s "$HOME/.profile_alias_os" ]]                   && source "$HOME/.profile_alias_os"
[[ -s "$HOME/.profile_custom" ]]                     && source "$HOME/.profile_custom"
