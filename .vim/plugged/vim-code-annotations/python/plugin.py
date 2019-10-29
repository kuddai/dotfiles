#!/usr/bin/env python2.7
'''
First, develop in the single file as it will be faster that way.
Then after initial prototype, split it into modules.
'''

from collections import namedtuple
import logging
import os
import sys
import vim


logging.basicConfig(stream=sys.stdout, level=logging.INFO)

# Constants
DEFAULT_FILENAME = 'annotations.md'

FINISH = 'FINISH'
TEXT_START = 'TEXT_START'
TEXT_END = 'TEXT_END'

Annotation = namedtuple('Annotation', ['link', 'text', 'lang'])

MAKRDOWN_ANNOTATION_TEMPLATE = \
'''

# {link}
```{lang}
{text}
```
'''


# Util
def get_default_filepath():
  return os.path.join(os.getcwd(), DEFAULT_FILENAME)

def get_buff_name():
  return vim.current.buffer.name

def get_file():
  return os.path.relpath(get_buff_name())

def get_line_nb():
  return vim.current.range.start

def detect_lang(name):
  if name.endswith('.py'):
    return 'python', '\n# ...\n'
  elif name.endswith('.js'):
    return 'javascript', '\n// ...\n'
  elif name.endswith('.cpp') or name.endswith('.h') or name.endswith('.cc'):
    return 'c++', '\n// ...\n'
  else:
    return '', '\n// ...\n'


# Main
class AnnotationTool(object):
  def __init__(self, filename=None):
    filename = DEFAULT_FILENAME if filename is None else filename
    self.filepath = os.path.join(os.getcwd(), filename)
    self.annotation_coroutine = None

  # Public API
  def annotate(self):
    if not self.annotation_coroutine:
      self.annotation_coroutine = self.start_annotation_coroutine()
    next(self.annotation_coroutine)

  def finish(self):
    if self.annotation_coroutine:
      try:
        self.annotation_coroutine.send(FINISH)
      except StopIteration:
        pass
      finally:
        self.annotation_coroutine = None


  # Private
  def start_annotation_coroutine(self):
    link = '{}:{}'.format(get_file(), get_line_nb())
    text_buffer = []
    state = TEXT_START
    buff_name = get_buff_name()
    line_nb = get_line_nb()
    lang, comment_format = detect_lang(buff_name)

    logging.info('Start annotating %s', link)

    while True:
      command = yield

      is_same_buffer = buff_name == get_buff_name()

      if is_same_buffer and state == TEXT_START:
        line_start = min(line_nb, get_line_nb())
        line_end = max(line_nb, get_line_nb())
        text_part = '\n'.join(vim.current.buffer[line_start:line_end + 1])
        text_buffer.append(text_part)

      if is_same_buffer and state == TEXT_END:
        line_nb = get_line_nb()

      if command == FINISH:
        logging.info('Finish annotating %s', link)
        text = comment_format.join(text_buffer)
        self.save(Annotation(link, text, lang))
        return

      state = TEXT_START if state == TEXT_END else TEXT_END
      logging.info('Current annotation state: %s', state)

  def save(self, annotation):
    '''Append annotation to the end of file.'''
    logging.info('Saving %s to %s', annotation.link, self.filepath)
    with open(self.filepath, 'a') as f:
      f.write(MAKRDOWN_ANNOTATION_TEMPLATE.format(**annotation._asdict()))
