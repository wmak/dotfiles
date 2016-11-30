#------------------------------------------------------------------------------
# TerminalInteractiveShell configuration
#------------------------------------------------------------------------------

# Options for displaying tab completions, 'column', 'multicolumn', and
# 'readlinelike'. These options are for `prompt_toolkit`, see `prompt_toolkit`
# documentation for more information.
c.TerminalInteractiveShell.display_completions = 'column'

# The name of a Pygments style to use for syntax highlighting:  manni, igor,
# lovelace, xcode, vim, autumn, vs, rrt, native, perldoc, borland, tango, emacs,
# friendly, monokai, paraiso-dark, colorful, murphy, bw, pastie, algol_nu,
# paraiso-light, trac, default, algol, fruity
c.TerminalInteractiveShell.highlighting_style = 'vim'

# Class used to generate Prompt token for prompt_toolkit
from IPython.terminal.prompts import Prompts, Token
class MyPrompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        return [
                (Token.Prompt, 'In {LOCL}<'),
                (Token.PromptNum, str(self.shell.execution_count)),
                (Token.Prompt, '>: '),
        ]

    def out_prompt_tokens(self, cli=None):
        return [
                (Token.Prompt, 'Out{LOCL}<'),
                (Token.PromptNum, str(self.shell.execution_count)),
                (Token.Prompt, '>: '),
        ]
c.TerminalInteractiveShell.prompts_class = MyPrompt
