# XIB HOT FIX
#
# Replaces sysVersion, toolsVersion and plugin to older versions
#
# Rafael Goncalves


import fnmatch
import os
import re

matches = []
for root, dirnames, filenames in os.walk('ReadingList'):
    for filename in fnmatch.filter(filenames, '*.xib'):
        file = open(os.path.join(root, filename), "r+")
        content = file.read()
        file.seek(0)
        file.truncate()
        content = re.sub("toolsVersion=\".*\"$", "toolsVersion=\"10116\"" , content)
        content = re.sub("systemVersion=\".*\"$", "systemVersion=\"15F34\"", content)
        content = re.sub("<plugIn identifier=\"com.apple.InterfaceBuilder.IBCocoaTouchPlugin\" version=\".*\"/>", "<plugIn identifier=\"com.apple.InterfaceBuilder.IBCocoaTouchPlugin\" version=\"10085\"/>" , content)
        content = re.sub("<capability name=\"documents saved in the Xcode 8 format\" minToolsVersion=\"8.0\"/>", "", content)
        file.write(content)
        print filename + " - Fixed!"
        file.close()
        
for root, dirnames, filenames in os.walk('ReadingList'):
    for filename in fnmatch.filter(filenames, '*.storyboard'):
        file = open(os.path.join(root, filename), "r+")
        content = file.read()
        file.seek(0)
        file.truncate()
        content = re.sub("toolsVersion=\".*\"$", "toolsVersion=\"10116\"" , content)
        content = re.sub("systemVersion=\".*\"$", "systemVersion=\"15F34\"", content)
        content = re.sub("<plugIn identifier=\"com.apple.InterfaceBuilder.IBCocoaTouchPlugin\" version=\".*\"/>", "<plugIn identifier=\"com.apple.InterfaceBuilder.IBCocoaTouchPlugin\" version=\"10085\"/>" , content)
        content = re.sub("<capability name=\"documents saved in the Xcode 8 format\" minToolsVersion=\"8.0\"/>", "", content)
        file.write(content)
        print filename + " - Fixed!"
        file.close()