module ApplicationHelper
  def user_avatar(user, width: 32)
    if user.image
      image_tag(user.image, width: width)
    end
  end
end
