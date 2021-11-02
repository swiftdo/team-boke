import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index")
    }
    
    
    let session = app.grouped([app.sessions.middleware,UserSessionAuthenticator(), User.guardMiddleware()])
    session.group("auth") { auth in
        auth.get("login") { req in
            return req.view.render("auth/login")
        }
        auth.get("register") { req in
            return req.view.render("auth/register")
        }
    }
    
    try session.register(collection: AdminController())
    
    try app.group("api") { api in
        try api.register(collection: AuthController())
    }
}
