import Vapor
import Leaf

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req  in
        return req.view.render("hello", ["name": "Leaf"])
    }
}
