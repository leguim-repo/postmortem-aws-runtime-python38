import logging
import os

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.NOTSET)


def print_os_environ():
    environ_keys = {}
    for k, v in sorted(os.environ.items()):
        LOGGER.info(f"{k}:{v}")
        environ_keys[k] = v


def show_modules():
    LOGGER.info(f'Info about modules in layer')
    LOGGER.info(f'all modules list\n: {str(help("modules"))}')
