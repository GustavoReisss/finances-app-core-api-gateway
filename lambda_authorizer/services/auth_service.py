from utils.response import make_response
from repositories.session_repository import SessionRepository, SessionNotFound
from tables.session import Session
from time import time

COOKIE_NAME = "sessionId"

# INVALIDATE_SESSION_RESPONSE = make_response(
#     status_code=401,
#     body={},
#     headers={
#         "Set-Cookie": f"{COOKIE_NAME}=%(session)s; HttpOnly; SameSite=Strict; Path=/; Secure; Max-Age=-1"
#     }
# )

# INTERNAL_SERVER_ERROR_RESPONSE = make_response(
#     status_code=500,
#     body={
#         "error_message": "Falha ao capturar ou recuperar o valor da sessão"
#     }
# )


class SessionExpired(Exception):
    pass


class AuthService:

    def __init__(self):
        self.session_resository = SessionRepository()

    def __check_session(self, session: Session):
        current_time = int(time())

        if current_time > session.expireOn:
            raise SessionExpired()

    def retrieve_session_data(self, session_id: str):
        try:
            if not session_id:
                raise SessionNotFound()

            print(f"[INFO] retrieving sessionId: {session_id}")
            session = self.session_resository.get_session(session_id=session_id)
            self.__check_session(session)

            return {"isAuthorized": True, "context": session.model_dump()}

        except (SessionNotFound, SessionExpired):
            # return INVALIDATE_SESSION_RESPONSE
            raise Exception("Unauthorized")

        except Exception as err:
            print("INTERNAL_SERVER_ERROR_RESPONSE ", err)
            raise err
            # return INTERNAL_SERVER_ERROR_RESPONSE
