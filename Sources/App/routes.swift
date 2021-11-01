import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index")
    }
    
    app.group("auth") { auth in
        auth.get("login") { req in
            return req.view.render("auth/login", ["name": "Login"])
        }
        auth.get("register") { req in
            return req.view.render("auth/register", ["name": "Register"])
        }
    }
    
    try app.group("api") { api in
        try api.register(collection: AuthController())
    }
}
