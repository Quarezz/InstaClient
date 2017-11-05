//
//  ImagesCacheService.swift
//  InstaClient
//
//  Created by Ruslan Nikolaev on 05/11/2017.
//  Copyright © 2017 Ruslan Nikolaev. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheService {
    
    // MARK: Public variables
    
    public var maxSize: NSInteger
    
    // MARK: Private variables
    
    fileprivate var dict: [String: LinkedList.Node]
    fileprivate var linkedList: LinkedList
    
    // MARK: Initialization
    
    init(maxSize: Int) {
        
        self.maxSize = maxSize
        self.linkedList = LinkedList()
        self.dict = [String:LinkedList.Node]()
    }
    
    // MARK: Public methods
    
    public func add(image: UIImage, forUrl url: String) {
    
        let node: LinkedList.Node
        if self.dict[url] != nil {
            node = self.dict[url]!
            self.linkedList.moveNodeToHead(node)
        }
        else {
            node = self.linkedList.insert(image: image, key: url)
            dict[url] = node
        }
        
        while (self.linkedList.size > self.maxSize) {
            
            if let tail = self.linkedList.removeTail() {
                self.dict[tail.key] = nil
            }
        }
    }
    
    public func getImage(forUrl url: String) -> UIImage? {
        
        if let node = self.dict[url] {

            self.linkedList.moveNodeToHead(node)
            return node.image
        }
        return nil
    }
    
    public func getAllImages() -> [UIImage] {
        
        return self.linkedList.allNodes().map({$0.image})
    }
    
    public func clear() {
        
        self.dict.removeAll()
        var node = self.linkedList.removeTail()
        while (node != nil) {
            node = self.linkedList.removeTail()
        }
    }
}

fileprivate class LinkedList {
    
    // MARK: Declarations
    
    class Node: NSObject {
        
        let key: String
        var image: UIImage
        
        var next: Node?
        var prev: Node?
        
        init(key: String, image: UIImage) {
            
            self.key = key
            self.image = image
            super.init()
        }
    }
    
    // MARK: Public variables
    
    public var size: Int = 0
    
    // MARK: Private variables
    
    private var head: Node?
    private var tail: Node?
    
    // MARK: Public methods
    
    func insert(image: UIImage, key: String) -> Node {
        
        let node = Node(key: key, image: image)
        self.insertAtHead(node)
        return node
    }
    
    public func moveNodeToHead(_ node: Node) {
        
        self.remove(node)
        self.insertAtHead(node)
    }
    
    public func removeTail() -> Node? {
        
        guard let node = self.tail else {
            return nil
        }
        self.remove(node)
        return node
    }
    
    public func allNodes() -> [Node] {
        
        guard let head = self.head else {
            return [Node]()
        }
        
        var array = [Node]()
        var node: Node? = head
        while (node != nil) {
            array.append(node!)
            node = node!.next
        }
        
        return array
    }
    
    // MARK: Private methods
    
    private func insertAtHead(_ node: Node) {
        
        self.size += UIImageJPEGRepresentation(node.image, 1)!.count
        
        if self.head == nil {
      
            self.head = node
            self.tail = node
            node.next = nil
            node.prev = nil
            return
        }
        else {
            
            node.next = self.head!
            node.prev = nil
            self.head!.prev = node
            self.head = node
        }
    }
    
    private func remove(_ node: Node) {
        
        self.size -= UIImageJPEGRepresentation(node.image, 1)!.count
        
        let previous = node.prev
        let next = node.next
        
        if node == self.head {
            self.head = next
        }
        if node == self.tail {
            self.tail = previous
        }
        
        previous?.next = next
        next?.prev = previous
        
        node.prev = nil
        node.next = nil
    }
}
