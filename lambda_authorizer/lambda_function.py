from services.auth_service import AuthService, COOKIE_NAME

__auth_service: AuthService = None

def __setup_services():
    global __auth_service

    if __auth_service:
        return

    __auth_service = AuthService()

def __get_session_id(event):
    cookies: list[str] = event.get("cookies", [])
    session = ""

    for c in [cookie for cookie in cookies if cookie.startswith(COOKIE_NAME)]:
        session = c.split("=")[1]
        break
    
    return session


def lambda_handler(event, context = None):
    try:
        __setup_services()
        session_id = __get_session_id(event)
    except Exception as err:
        print(err)
        raise err

    return __auth_service.retrieve_session_data(session_id=session_id)


if __name__ == "__main__":
    event = {
        "cookies": [f"{COOKIE_NAME}=968c28a93092ba312747b6f4374d585f"]
    }

    print(lambda_handler(event))
    