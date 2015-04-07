$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mpt_tree/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mpt_tree"
  s.version     = MptTree::VERSION
  s.authors     = ["Prashant Raghav"]
  s.email       = ["prashantraghav@gmail.com"]
  s.homepage    = "https://github.com/prashantraghav/mpt_tree"
  s.summary     = "based on modified preorder tree traversal algorithm"
  s.description = "MptTree allows any rails model to work as tree."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
end
