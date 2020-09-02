import App
import Vapor

var env = Environment.detect()

let app = Application(env)

defer { app.shutdown() }

try configure(app)
try app.run()
