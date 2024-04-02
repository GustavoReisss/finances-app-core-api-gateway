import json

def make_response(status_code: int, body, headers: dict = {}):
    return {
        "statusCode": status_code,
        "body": json.dumps(body),
        "headers": headers
    }