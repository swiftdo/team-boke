import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req  in
        return req.view.render("hello", ["name": "Leaf"])
    }

    app.get("login") { req in 
        return req.view.render("login", ["name": "Login"])
    }

    app.get("register") { req in 
        return req.view.render("register", ["name": "Register"])
    }
    
    
    try app.group("api") { api in
        try api.register(collection: AuthController())
    }
}
