from flask import Flask, request

from src import microservices, repository
from src.validators import validate_schema
from src.schemas import vote_schema

app = Flask(__name__)
BASE_PATH = "/api/vote"


@app.route(BASE_PATH, methods=['HEAD'])
def head():
    return ""


@validate_schema(schema=vote_schema)
@app.route(BASE_PATH, methods=['POST'])
def post():
    vote_json = request.get_json()
    repository.vote(vote_json)
    microservices.increment_pool(vote_json['pool_id'])
    return "", 201
