from __future__ import (absolute_import, division, print_function)

from ranger.colorschemes.default import Default
from ranger.gui.color import red, blue, green


class Scheme(Default):

    def use(self, context):
        fg, bg, attr = Default.use(self, context)

        if context.in_titlebar and context.hostname:
            fg = red if context.bad else blue

        if context.in_titlebar and context.directory:
            fg = green

        return fg, bg, attr
