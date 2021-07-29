try:
    from qutebrowser.config.configfiles import ConfigAPI # noqa: F401
    from qutebrowser.config.config import ConfigContainer # noqa: F401
except ImportError as e:
    raise Exception(f"qutebrowser appears to be not installed, error: {e}")

c: ConfigContainer
config: ConfigAPI

config.load_autoconfig()

c.aliases = {
    "q": "close",
    "qa": "quit",
    "w": "session-save",
    "wq": "quit --save",
    "wqa": "quit --save",
    "o": "open"
}
c.tabs.position = "right"
c.completion.shrink = True
c.messages.timeout = 5000
c.url.start_pages = ["about:blank"]
c.url.default_page = "about:blank"
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "g": "https://google.com/search?q={}",
    "d": "https://duckduckgo.com/?q={}",
    "wa": "https://wiki.archlinux.org/?search={}"
}
c.url.auto_search = "never"
c.confirm_quit = ["multiple-tabs", "downloads"]
c.content.default_encoding = "utf-8"
c.content.site_specific_quirks = True
c.downloads.location.prompt = False
c.editor.command = ["nvim-qt", "--nofork", "{file}"]
c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.123 Safari/537.36"
c.session.lazy_restore = True
c.tabs.last_close = "blank"
c.tabs.new_position.related = "next"
c.tabs.new_position.unrelated = "last"
c.tabs.show = "multiple"
c.tabs.width = 96
c.tabs.indicator.padding = {
    "bottom": 2,
    "left": 0,
    "right": 0,
    "top": 2
}
c.tabs.padding = {
    "bottom": 0,
    "left": 0,
    "right": 0,
    "top": 0
}
c.tabs.indicator.width = 0
c.tabs.title.format = "{current_title}"

c.content.host_blocking.enabled = True
c.content.host_blocking.lists = [
    # TODO: add more lists
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts'
]

config.bind("<Ctrl-Shift-v>", "spawn mpv {url}")
config.bind("<Ctrl-Shift-e>", "spawn nomacs {url}")
config.bind("<Ctrl-d>", "bookmark-add")
config.bind("<Ctrl-Shift-i>", "devtools")
config.bind("<Alt-Left>", "back")
config.bind("<Alt-Right>", "forward")
config.bind("<Shift-Escape>", "jseval document.activeElement.blur();", "insert")
config.bind("<Ctrl-Shift-r>", "spawn --userscript readability")
