# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os
import shutil

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command
from ranger.core.loader import CommandLoader

# Any class that is a subclass of "Command" will be integrated into ranger as a command.

class archive_view(Command):
    def execute(self):
        tmp_folder = "/tmp/archive_view"
        self._show(tmp_folder)
        self._extract(self.fm.thisfile, tmp_folder)
    
    def _show(self, folder):
        feh_flags = ['-r', '-T', 'normal']
        descr = "Opening"
        obj = CommandLoader(args=['feh'] + feh_flags + ["/tmp/archive_view"], descr=descr, read=False)
        self.fm.loader.add(obj)

    def _extract(self, archive, folder):
        if not os.path.exists(folder): # If folder does not exist, create it
            os.mkdir(folder)
        else:                              # Otherwise delete w/e is inside
            for the_file in os.listdir(folder):
                file_path = os.path.join(folder, the_file)
                try:
                    if os.path.isfile(file_path):
                        os.unlink(file_path)
                    elif os.path.isdir(file_path): 
                        shutil.rmtree(file_path)
                except Exception as e:
                    self.fm.notify(e)

        au_flags = ['-X', folder]
        descr = "Extracting: " + os.path.basename(archive.path)
        obj = CommandLoader(args=['aunpack'] + au_flags + [archive.path], descr=descr, read=True)
        self.fm.loader.add(obj)
