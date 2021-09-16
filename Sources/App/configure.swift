import Vapor
import Leaf

// configures your application
public func configure(_ app: Application) throws {
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.views.use(.leaf)
    // app.leaf.cache.isEnabled = app.environment.isRelease
    try routes(app)
}
