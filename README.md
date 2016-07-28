#mpt_tree
by Prashant Raghav

Mpt_tree is a flexible solution to make any model work as tree structure. It is based on modified preorder traversal algorithm

* is Rake based.
* allows any model to work as tree.
* based on abstraction and modularity concept: use only what you need
* use the multiple table inheritance concept of Rails ActiveRecord impressively.


##Getting started
You can add it to your Gemfile with:
```ruby
gem 'mpt_tree'
```
Run the bundle command to install it.

After you install mpt_tree and add it to your Gemfile, you need install the migrations of mpt_tree
```console
rake mpt_tree:install:migrations
```
This will copy the migration need to operate tree sturcure in your applicaion. 

After you copied the migrations from mpt_tree. you need to run generator.
```console
rails g tree MODEL
```
you can also give attributes as arguments for your model as you give to generate a simple model in rails
```console
rails g tree MODEL ATTRIBUTE:TYPE
```
####for example: 
Let`s assume you need a tree structure model for 'Team' with an attribute 'name'. You need to run
```console
rails g tree team name:string
```

this generator will create.
- an initializer file if not exist. 'config/initializers/mpt_tree.rb'
- a migration file 
- a model file

After you have generated the tree model, you need to run migration
```console
rake db:migrate
```

###Methods to navigate the tree
#####Instance methods
```console
  make_it_root            makes the current node as root
  tree                    returns the list of childrens
  insert(object)          makes the object as child of node.
  parent                  returns the parent of node.
  siblings                returns the list of siblings
  children                returns the list of childrens
  root?                   returns true if node is root otherwise false
  leaf?                   returns true if node is leaf otherwise false
  ancestors               returns the list of ancestors
  self_with_ancestors     returns the list of ancestors and self object 
  nodes_at_level(level)   reutrns the list of nodes at given level.
  change_parent(object)   change the parent of node to object if the node is leaf.     
```
#####Class methods
```console
  root                    returns the root node
```

##Contributing and license
mpt_tree will be updated with the changing version of Ruby and Rails, also new methods will be added to give more features and enhance the performace.

Question? Bug report? Faulty/incomplete documentation? Feature request? Please post an issue

Copyright (c) 2015 Prashant Raghav, released under the MIT license
