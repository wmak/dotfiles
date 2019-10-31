try:
    from IPython.terminal.prompts import Prompts, Token

    class IPythonPrompt(Prompts):
        def in_prompt_tokens(self, cli=None):
            return [
                (Token.Prompt, 'In ['),
                (Token.PromptNum, str(self.shell.execution_count)),
                (Token.Prompt, '] {'),
                (Token.PromptNum, 'dev'),
                (Token.Prompt, '}: ')
            ]

        def out_prompt_tokens(self, cli=None):
            return [
                (Token.OutPrompt, 'Out['),
                (Token.OutPromptNum, str(self.shell.execution_count)),
                (Token.OutPrompt, '] {'),
                (Token.OutPromptNum, 'dev'),
                (Token.OutPrompt, '}: ')
            ]

    _ip = get_ipython()  # noqa
    _ip.prompts = IPythonPrompt(_ip)
except Exception:
    pass
