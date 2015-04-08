require "mpt_tree/engine"

module MptTree
  
  def acts_as_tree
    has_one :mpt_tree_node, :as=>:tree, :dependent=>:destroy, :class_name=>"MptTree::Node"
    default_scope lambda {joins(:mpt_tree_node).order('mpt_tree_nodes.lft')}

    class_eval do 
      def make_it_root
        create_mpt_tree_node #unless MptTree::Node.root_created? self.class.name
      end

      def tree
        node_ids = mpt_tree_node.tree
        self.class.name.constantize.where(:id => node_ids)
      end

      def insert(node)
        raise "can not be inserted! node already have parent." if node.mpt_tree_node
        mpt_tree_node.insert(node)
      end

      def parents
        node_ids = mpt_tree_node.parents
        self.class.name.constantize.where(:id => node_ids)
      end

      def level(parent=nil)
        mpt_tree_node.level(parent)
      end

      def nodes_at_level(level)
        nodes = Array.new
        tree.each do |node|
          nodes << node if node.level(self) == level
        end
        nodes
      end

      def change_parent(node)
        mpt_tree_node.destroy
        node.insert(self)
      end

      alias_method :<<, :insert
    end
  end
end
