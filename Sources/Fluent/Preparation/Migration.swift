final class Migration: Entity {
    static var entity = "fluent"
    let storage = Storage()
    var name: String

    init(name: String) {
        self.name = name
    }

    init(node: Node, in context: Context) throws {
        name = try node.extract("name")
        id = try node.extract(idKey)
    }

    func makeNode(context: Context = EmptyNode) throws -> Node {
        return try Node(node: [
            idKey: id,
            "name": name
        ])
    }

    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id(for: self)
            builder.string("name")
        }
    }

    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
