module MptTree
  class TreeNode < ActiveRecord::Base
    belongs_to :tree, :polymorphic=>true

    before_create :create_root_node
    before_destroy :delete_node


    def insert(node)
      TreeNode.transaction do
        TreeNode.where(:tree_type=>tree_type).where("rgt >= :rgt", :rgt=>self.rgt).update_all("rgt=rgt+2")
        TreeNode.where(:tree_type=>tree_type).where("lft > :rgt", :rgt=>self.rgt).update_all("lft=lft+2")
        node.create_tree_node(:lft => self.rgt, :rgt=>self.rgt+1)
      end
    end

    def tree
      TreeNode.where(:tree_type=>tree_type).where("lft > ? AND rgt < ?", self.lft, self.rgt ).order('lft').map(&:tree_id)
    end

    def parents
      TreeNode.where(:tree_type=>tree_type).where("lft < ? AND rgt > ?", self.lft, self.rgt).order('lft').map(&:tree_id)
    end

    def leaf?
      self.rgt == self.lft+1
    end

    def level(parent=nil)
      sql = "lft < :self_lft AND rgt > :self_rgt "
      arguments = {:self_lft=>self.lft, :self_rgt=>self.rgt}
      if parent
        sql+= "AND lft >= :parent_lft AND rgt <= :parent_rgt"  
        arguments[:parent_lft]=parent.tree_node.lft; arguments[:parent_rgt]=parent.tree_node.rgt;
      end
      TreeNode.where(:tree_type=>tree_type).where(sql, arguments).count(:id)
    end


    private
    def delete_node
      allow_delete = false
      if(self.leaf?)
        TreeNode.where(:tree_type=>tree_type).where("lft > ?", self.rgt).update_all("lft = lft-2")
        TreeNode.where(:tree_type=>tree_type).where("rgt > ?", self.rgt).update_all("rgt = rgt-2")
        allow_delete = true
      end
      allow_delete
    end

    def create_root_node
      self.lft, self.rgt = 1, 2  if TreeNode.where(:tree_type=>tree_type).empty?
    end

  end
end