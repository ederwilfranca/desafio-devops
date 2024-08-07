from flask import Flask
from .config import Config
from .routes import api_bp


def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    app.register_blueprint(api_bp, url_prefix='/api')

    return app
