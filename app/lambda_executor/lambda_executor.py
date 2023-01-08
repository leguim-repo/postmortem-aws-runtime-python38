import json

import boto3

from app.common.tools import print_os_environ, show_lib_versions, LOGGER


def launch_another_lambda(payload) -> None:
    client = boto3.client("lambda")
    invoke_response = client.invoke(
        FunctionName="lambda_dummy",
        InvocationType="RequestResponse",
        Payload=payload,
    )
    LOGGER.info(f"invoke_response: {str(invoke_response)}")
    LOGGER.info(f'StatusCode {str(invoke_response["StatusCode"])}')
    res_stream_body = invoke_response["Payload"].read().decode("utf-8")
    LOGGER.info(f"StreamingBody {str(res_stream_body)}")


def handler(event, context):
    LOGGER.info(event)
    LOGGER.info(context.get_remaining_time_in_millis())
    print_os_environ()
    show_lib_versions()
    launch_another_lambda(payload=event)
    return {"statusCode": 200, "event": json.dumps(event)}
