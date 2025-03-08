#
# Completion
#

# Boost evaluated tools like zoxide

# Additional completion definitions for Zsh.
zmodule clarketm/zsh-completions --fpath src
# Enables and configures smart and extensive tab completion.
# completion must be sourced after all modules that add completion definitions.
zmodule completion
