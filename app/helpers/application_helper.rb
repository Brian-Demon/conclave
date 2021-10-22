module ApplicationHelper
  def user_avatar(user, width: 32)
    if user.image
      image_tag(user.image, width: width)
    end
  end

  def page_link_tree(category, discussion)
    root_link = link_to("Conclave", categories_path, class: "hover:text-yellow-700")
    category_link = link_to(category.name, category, class: "hover:text-yellow-700")
    discussion_link = link_to(discussion.title, [category, discussion], class: "hover:text-yellow-700") if discussion
    [root_link, category_link, discussion_link].compact.join(" > ").html_safe
  end
end
