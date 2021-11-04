import Vapor
import Leaf
import LeafKit
import Fluent
import FluentPostgresDriver

public func configure(_ app: Application) throws {
    
    /// 初始化环境
    app.myConfig = .init()
    
    // 中间件配置
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(app.sessions.middleware)
    
    let corsConfiguration = CORSMiddleware.Configuration(
        allowedOrigin: .all,
        allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
        allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin]
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    app.middleware.use(cors, at: .beginning)
    
    // leaf 配置为 html 后缀
    let detected = app.directory.viewsDirectory
    app.leaf.sources = .singleSource(NIOLeafFiles(fileio: app.fileio,
                                                  limits: .default,
                                                  sandboxDirectory: detected,
                                                  viewDirectory: detected,
                                                  defaultExtension: "html"))
    app.views.use(.leaf)
    
    
    
    // 数据库配置
    if let databaseURL = Environment.get("DATABASE_URL"), var postgresConfig = PostgresConfiguration(url: databaseURL) {
        postgresConfig.tlsConfiguration = .forClient(certificateVerification: .none)
        app.databases.use(.postgres(
            configuration: postgresConfig
        ), as: .psql)
    } else {
        app.databases.use(.postgres(hostname: "localhost",
                                username: "vapor",
                                password: "vapor",
                                database: "blog"),
                          as: .psql)
    }
    
    try routes(app)
    try migrations(app)
    try services(app)
}
