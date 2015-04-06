module TeamsHelper
  def tree_view(team)
    return unless team
    html= "<b>#{link_to_show(team)}</b><br/>"
    team.tree.each do |node|
      html+= "&nbsp;"*3*node.level(team)+link_to_show(node)+"<br/>"
    end
    return raw(html)
  end

  def parents_breadcrumbs(team)
    return unless team
    html ="<span>"
    team.parents.each_with_index do | parent, index |
      html+=link_to_show(parent)
      html+="<small> > </small>" if index < team.parents.count-1
    end
    html+="</span>"
    return raw(html)
  end

  def link_to_show(node)
    link_to(node.name, {:action=>"show", :id=>node.id})
  end

  def link_to_edit(node)
    link_to("edit", {:action=>"edit", :id=>node.id})
  end

  def link_to_add_child(node)
    link_to("add child", {:action=>"child", :id=>node.id})
  end

  def link_to_delete(node)
    link_to("delete", {:action=>"delete", :id=>node.id})
  end

  def link_to_childs(node)
    link_to("childs", {:action=>"index", :id=>node.id})
  end
end
