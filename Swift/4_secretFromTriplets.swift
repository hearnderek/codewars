class Node {
    let value: String // the character
    var distance : Int // from head
    var children : [Node] // characters known to come after this one

    init(value: String, distance: Int, children: [Node] = []) {
        self.value = value
        self.distance = distance
        self.children = []
        for child in children {
            self.children.append(child)
        }

    }

    func addChild(_ child: Node) {   
        if child.distance < distance + 1 {
            child.distance = distance + 1
        }
        child.updateChildDistance()
        
        for existingChild in children {
            if existingChild.value == child.value {
                return
            }
        }
        children.append(child)
    }

    func updateChildDistance() {
        for child in children {
            if child.distance < distance + 1 {
                child.distance = distance + 1
                child.updateChildDistance()
            }
        }
    }
}


func recoverSecret(from triplets: [[String]]) -> String {
    var lookup: [String: Node] = [:]

    // Unpack input
    for triplet in triplets {
        let fst = triplet[0]
        let snd = triplet[1]
        let trd = triplet[2]

        if lookup[fst] == nil {
            lookup[fst] = Node(value: fst, distance: 0)
        }
        if lookup[snd] == nil {
            lookup[snd] = Node(value: snd, distance: 1)
        }
        if lookup[trd] == nil {
            lookup[trd] = Node(value: trd, distance: 2)
        }
        
        let trdNode: Node = lookup[trd]!
        let sndNode: Node = lookup[snd]!
        let fstNode: Node = lookup[fst]!
        
        sndNode.addChild(trdNode)
        fstNode.addChild(trdNode)
        fstNode.addChild(sndNode)
    }

    // Assuming well formed input will be only ever be one node with distance 0
    var head: Node? = nil
    for key in lookup.keys {
        let v = lookup[key]!
        if v.distance == 0 {
            head = v
            break
        }
    }

    
    // Walk down the tree and build the string
    var result = ""
    while head != nil {
        result += head!.value
        if head!.children.count == 0 {
            break
        }

        for child in head!.children {
            if child.distance == head!.distance + 1 {
                head = child
                break
            }
        }
    }

    return result
}

