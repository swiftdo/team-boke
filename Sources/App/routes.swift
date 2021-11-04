import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index")
    }
    try app.register(collection: AdminController())
    try app.register(collection: AuthController())
}
