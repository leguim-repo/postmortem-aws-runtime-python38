import json

from app.common.tools import print_os_environ, show_modules, LOGGER


def handler(event, context):
    LOGGER.info(event)
    LOGGER.info(f"Remaining time {context.get_remaining_time_in_millis()}")
    print_os_environ()
    show_modules()
    return {"statusCode": 200, "event": json.dumps(event)}
