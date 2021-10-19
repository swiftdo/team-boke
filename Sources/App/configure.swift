import Vapor
import Leaf
import LeafKit
import Fluent
import FluentPostgresDriver

public func configure(_ app: Application) throws {
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    let error = ErrorMiddleware.custom(environment: app.environment)
    
    app.middleware.use(error)
    app.middleware.use(cors, at: .beginning)
    
    
    // leaf 配置为 html 后缀
    let detected = app.directory.viewsDirectory
    app.leaf.sources = .singleSource(NIOLeafFiles(fileio: app.fileio,
                                                  limits: .default,
                                                  sandboxDirectory: detected,
                                                  viewDirectory: detected,
                                                  defaultExtension: "html"))
    app.views.use(.leaf)
    // app.leaf.cache.isEnabled = app.environment.isRelease
    

    app.databases.use(.postgres(hostname: "localhost",
                                username: "vapor",
                                password: "vapor",
                                database: "blog"),
                      as: .psql)
    try routes(app)
    try migrations(app)
    try services(app)
    
}
