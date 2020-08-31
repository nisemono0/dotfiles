import os
import shutil

from ranger.api.commands import Command
from ranger.core.loader import CommandLoader

class extract_view(Command):
    """ Unpacks image archives into /tmp/archive_view and displays them with feh """
    
    def execute(self):
        tmp_folder = "/tmp/archive_view"
        self._extract(self.fm.thisfile, tmp_folder)
        self._show(tmp_folder)

    def _show(self, folder):
        try:
            descr = "Opening {}".format(folder)
            cmd = ['feh', '-r', folder]
            obj = CommandLoader(args=cmd, descr=descr, read=False)
            self.fm.loader.add(obj, append=True)
        except Exception as e:
            self.fm.notify(e)
            return
        
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
                    return
        try:
            cmd = ['aunpack', '-X', folder, archive.path]
            descr = "Extracting: {}".format(archive.basename)
            obj = CommandLoader(args=cmd, descr=descr, read=True)
            self.fm.notify("Extracting: {}".format(archive.basename))
            self.fm.loader.add(obj, append=True)
        except Exception as e:
            self.fm.notify(e)
            return
