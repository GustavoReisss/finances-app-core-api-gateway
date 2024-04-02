from env.ddb_client import get_ddb_client
from tables.session import SessionTable, Session
from boto3.dynamodb.conditions import Key

CACHED_SESSIONS = {}

class SessionNotFound(Exception):
    pass


class SessionRepository:

    def __init__(self) -> None:
        self.session_table = SessionTable()
        self.ddb_table = get_ddb_client().Table(self.session_table.name)


    def __retrive_session(self, session_id: str):
        try:
            return self.ddb_table.query(
                KeyConditionExpression=Key(self.session_table.partition_key).eq(session_id)
            )["Items"][0]
        except IndexError:
            raise SessionNotFound()


    def get_session(self, session_id: str) -> Session:
        if session_id not in CACHED_SESSIONS:        
            session = self.__retrive_session(session_id)
            CACHED_SESSIONS[session_id] = session

        return Session(**CACHED_SESSIONS.get(session_id))