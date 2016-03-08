import os
import json
import codecs
from collections import namedtuple
# import traceback as tb

NEW_LINE = '\n'
BUFFER_MAX = 5000


def to_unicode(text, encoding='utf-8'):
    if not isinstance(text, unicode):
        text = unicode(text, encoding)
    return text


def writeToFile(filename, line, mode='a'):
    """
    - mode can have either of 'w' or 'a' as its value
    - this function is not responsible for printing '\n' character
    """
    with codecs.open(filename, mode, encoding='utf-8') as ofile:
        ofile.write(line)


def deleteFiles(file_list):
    for fname in file_list:
        if os.path.isfile(fname):
            d, f = os.path.split(fname)
            print f + " exists. Deleting..."
            os.remove(fname)


class FileWriteBuffer:
    def __init__(self, filename, buffer_max=None, delim=None):
        self.filename = filename
        self.buf_max = buffer_max if buffer_max else BUFFER_MAX
        self.delim = delim if delim else NEW_LINE
        self.Buffer = []

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        if exc_type:
            # No point in handling the error here. Let the caller handle it
            # tb.print_exception(exc_type, exc_value, traceback)
            raise exc_type, exc_value, traceback
        if len(self.Buffer) > 0:
            writeToFile(self.filename, (self.delim).join(
                self.Buffer) + self.delim)
            self.Buffer = []

    def write(self, text):
        self.Buffer.append(text)
        if len(self.Buffer) == self.buf_max:
            writeToFile(self.filename, (self.delim).join(
                self.Buffer) + self.delim)
            self.Buffer = []


def cleanupToken(token, reps_allowed=1):
    """
    reps_allowed : no. of repretitions allowed. For example:
        'sloooow' -> 'slow' for reps_allowed = 0
        'sloooow' -> 'sloow' for reps_allowed = 1
    """
    Extra = namedtuple('Extra', ['index', 'times'])
    extra_occurences = []
    prev = ''
    counter = 0
    for i in range(len(token)):
        if token[i] == prev:
            counter += 1
        else:
            if counter > reps_allowed:
                pos = i - (counter - reps_allowed)
                extra = counter - reps_allowed
                extra_occurences.append(Extra(index=pos, times=extra))
            counter = 0
            prev = token[i]
    if counter > reps_allowed:
        pos = i - (counter - reps_allowed)
        extra = counter - reps_allowed
        extra_occurences.append(Extra(index=pos, times=extra))
    new_token = list(token)
    deleted = 0
    for extra in extra_occurences:
        for _ in range(extra.times):
            del new_token[extra.index - deleted]
        deleted += extra.times
    return ''.join(new_token)


def loadJSON(filename):
    with open(filename) as ifi:
        json_tree = json.load(ifi)
    return json_tree


def loadAllLines(filename):
    with open(filename) as ifi:
        all_lines = ifi.readlines()
    return all_lines


def saveJSON(obj, filename):
    with open(filename, 'w') as ofi:
        json.dump(obj, ofi)
