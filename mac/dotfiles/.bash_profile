# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# Load my settings
[[ -s "$HOME/.profile_colors" ]] && source "$HOME/.profile_colors"
[[ -s "$HOME/.profile_path" ]] && source "$HOME/.profile_path"
[[ -s "$HOME/.profile_alias_common" ]] && source "$HOME/.profile_alias_common"
[[ -s "$HOME/.profile_alias_os" ]] && source "$HOME/.profile_alias_os"
[[ -s "$HOME/.profile_custom" ]] && source "$HOME/.profile_custom"
